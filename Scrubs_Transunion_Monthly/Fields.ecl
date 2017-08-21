IMPORT ut,SALT32;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'record_type','first_name','middle_name','last_name','name_prefix','name_suffix_','perm_id','ssn','aka1','aka2','aka3','new_subject_flag','name_change_flag','address_change_flag','ssn_change_flag','file_since_date_change_flag','deceased_indicator_flag','dob_change_flag','phone_change_flag','filler2','gender','mfdu_indicator','file_since_date','house_number','street_direction','street_name','street_type','street_post_direction','unit_type','unit_number','cty','state','zip_code','zp4','address_standardization_indicator','date_address_reported','party_id','deceased_indicator','date_of_birth','date_of_birth_estimated_ind','phone','filler3','prepped_name','prepped_addr1','prepped_addr2','prepped_rec_type','isupdating','iscurrent','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','clean_phone','clean_ssn','clean_dob','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','isdelete');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'record_type' => 1,'first_name' => 2,'middle_name' => 3,'last_name' => 4,'name_prefix' => 5,'name_suffix_' => 6,'perm_id' => 7,'ssn' => 8,'aka1' => 9,'aka2' => 10,'aka3' => 11,'new_subject_flag' => 12,'name_change_flag' => 13,'address_change_flag' => 14,'ssn_change_flag' => 15,'file_since_date_change_flag' => 16,'deceased_indicator_flag' => 17,'dob_change_flag' => 18,'phone_change_flag' => 19,'filler2' => 20,'gender' => 21,'mfdu_indicator' => 22,'file_since_date' => 23,'house_number' => 24,'street_direction' => 25,'street_name' => 26,'street_type' => 27,'street_post_direction' => 28,'unit_type' => 29,'unit_number' => 30,'cty' => 31,'state' => 32,'zip_code' => 33,'zp4' => 34,'address_standardization_indicator' => 35,'date_address_reported' => 36,'party_id' => 37,'deceased_indicator' => 38,'date_of_birth' => 39,'date_of_birth_estimated_ind' => 40,'phone' => 41,'filler3' => 42,'prepped_name' => 43,'prepped_addr1' => 44,'prepped_addr2' => 45,'prepped_rec_type' => 46,'isupdating' => 47,'iscurrent' => 48,'did' => 49,'did_score' => 50,'dt_first_seen' => 51,'dt_last_seen' => 52,'dt_vendor_last_reported' => 53,'dt_vendor_first_reported' => 54,'clean_phone' => 55,'clean_ssn' => 56,'clean_dob' => 57,'title' => 58,'fname' => 59,'mname' => 60,'lname' => 61,'name_suffix' => 62,'name_score' => 63,'prim_range' => 64,'predir' => 65,'prim_name' => 66,'addr_suffix' => 67,'postdir' => 68,'unit_desig' => 69,'sec_range' => 70,'p_city_name' => 71,'v_city_name' => 72,'st' => 73,'zip' => 74,'zip4' => 75,'cart' => 76,'cr_sort_sz' => 77,'lot' => 78,'lot_order' => 79,'dbpc' => 80,'chk_digit' => 81,'rec_type' => 82,'fips_county' => 83,'county' => 84,'geo_lat' => 85,'geo_long' => 86,'msa' => 87,'geo_blk' => 88,'geo_match' => 89,'err_stat' => 90,'rawaid' => 91,'isdelete' => 92,0);
 
EXPORT MakeFT_record_type(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_record_type(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123 '))),~(LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123 '),SALT32.HygieneErrors.NotLength('2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_first_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_first_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 12),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('5,6,7,4,8,9,3,1,10,11,2,12'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_middle_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_middle_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT32.HygieneErrors.NotLength('1,0,5,4,6,3,7,8,2,9,10'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_last_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_last_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('6,7,5,8,4,9,10,3,11,12,13,2,14,15,16,17'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_name_prefix(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'DLMNRSV '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_prefix(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'DLMNRSV '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_prefix(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('DLMNRSV '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_name_suffix_(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' DIJRSV '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_name_suffix_(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' DIJRSV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_suffix_(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars(' DIJRSV '),SALT32.HygieneErrors.NotLength('0,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_perm_id(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789ABCDEF '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_perm_id(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789ABCDEF '))),~(LENGTH(TRIM(s)) = 12),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_perm_id(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789ABCDEF '),SALT32.HygieneErrors.NotLength('12'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_ssn(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ssn(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('9,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_aka1(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,',ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aka1(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,',ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 29),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_aka1(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(',ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('0,15,16,14,17,13,18,19,12,20,11,21,22,10,23,24,9,25,8,26,7,27,29'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_aka2(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,',ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aka2(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,',ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 29),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_aka2(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(',ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT32.HygieneErrors.NotLength('0,15,14,16,13,17,18,12,19,20,11,21,22,10,23,9,24,25,8,26,7,29'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_aka3(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,',ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aka3(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,',ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 26),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_aka3(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(',ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT32.HygieneErrors.NotLength('0,15,14,16,17,13,18,12,19,20,11,21,22,10,23,24,9,25,8,26'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_new_subject_flag(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_new_subject_flag(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_new_subject_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('NY '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_name_change_flag(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_change_flag(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_change_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('NY '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_address_change_flag(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_address_change_flag(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_address_change_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('NY '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_ssn_change_flag(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ssn_change_flag(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ssn_change_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('NY '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_file_since_date_change_flag(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_file_since_date_change_flag(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_file_since_date_change_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('NY '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_deceased_indicator_flag(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_deceased_indicator_flag(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_deceased_indicator_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('NY '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_dob_change_flag(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dob_change_flag(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dob_change_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('NY '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_phone_change_flag(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone_change_flag(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_phone_change_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('NY '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_filler2(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_filler2(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_filler2(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_gender(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'FIMU '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gender(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'FIMU '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('FIMU '),SALT32.HygieneErrors.NotLength('0,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_mfdu_indicator(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'MSU '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mfdu_indicator(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'MSU '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mfdu_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('MSU '),SALT32.HygieneErrors.NotLength('0,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_file_since_date(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_file_since_date(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_file_since_date(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('8'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_house_number(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' 0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_house_number(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' 0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_house_number(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars(' 0123456789 '),SALT32.HygieneErrors.NotLength('10,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_street_direction(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_street_direction(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_street_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ENSW '),SALT32.HygieneErrors.NotLength('0,1,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_street_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_street_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 23),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 4 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 5));
EXPORT InValidMessageFT_street_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('6,7,8,4,5,9,10,11,12,3,13,14,15,16,17,1,18,2,19,20,21,27,22,23'),SALT32.HygieneErrors.NotWords('1,2,3,4,5'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_street_type(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEHIKLNOPQRSTVWYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_street_type(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEHIKLNOPQRSTVWYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 4),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_street_type(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ABCDEHIKLNOPQRSTVWYZ '),SALT32.HygieneErrors.NotLength('2,0,3,4'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_street_post_direction(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_street_post_direction(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_street_post_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ENSW '),SALT32.HygieneErrors.NotLength('0,2,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_unit_type(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' #ABCEFILNOPRSTUX '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_unit_type(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' #ABCEFILNOPRSTUX '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 4),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_unit_type(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars(' #ABCEFILNOPRSTUX '),SALT32.HygieneErrors.NotLength('0,3,1,4'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_unit_number(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_unit_number(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_unit_number(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWY '),SALT32.HygieneErrors.NotLength('0,1,3,2,4,5'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_cty(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cty(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_cty(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT32.HygieneErrors.NotLength('7,8,9,6,10,11,12,5,13,14,4,15,16,17,3,18,19,20'),SALT32.HygieneErrors.NotWords('1,2,3'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_state(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_state(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_zip_code(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip_code(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip_code(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('5'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_zp4(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_zp4(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zp4(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('4,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_address_standardization_indicator(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_address_standardization_indicator(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_address_standardization_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('NY '),SALT32.HygieneErrors.NotLength('1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_date_address_reported(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_address_reported(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_date_address_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('8,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_party_id(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_party_id(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 15),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_party_id(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('15'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_deceased_indicator(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'Y '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_deceased_indicator(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'Y '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_deceased_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('Y '),SALT32.HygieneErrors.NotLength('0,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_date_of_birth(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_of_birth(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_date_of_birth(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('8,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_date_of_birth_estimated_ind(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'E '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_of_birth_estimated_ind(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'E '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_date_of_birth_estimated_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('E '),SALT32.HygieneErrors.NotLength('0,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_phone(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('0,10'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_filler3(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_filler3(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_filler3(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_prepped_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 6),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 4));
EXPORT InValidMessageFT_prepped_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('15,16,14,17,13,18,12,19,20,11,21,10,22,23,9,24,25,8,26,7,27,28,29,6'),SALT32.HygieneErrors.NotWords('2,1,3,4'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_prepped_addr1(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' #0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_addr1(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' #0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 30 OR LENGTH(TRIM(s)) = 31 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 32 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 33 OR LENGTH(TRIM(s)) = 34 OR LENGTH(TRIM(s)) = 5),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 4 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 5 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 6 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 7 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 8));
EXPORT InValidMessageFT_prepped_addr1(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' #0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('15,16,14,17,13,18,19,12,20,11,21,10,22,23,24,25,9,26,27,28,8,29,30,31,4,32,7,6,33,34,5'),SALT32.HygieneErrors.NotWords('3,4,5,6,2,7,8'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_prepped_addr2(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ,0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_addr2(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ,0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 30),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 4 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 5));
EXPORT InValidMessageFT_prepped_addr2(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ,0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('17,18,19,16,20,21,22,15,23,24,14,25,26,27,13,28,29,30'),SALT32.HygieneErrors.NotWords('3,4,5'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_prepped_rec_type(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'123ABCD '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_rec_type(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'123ABCD '))),~(LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_prepped_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('123ABCD '),SALT32.HygieneErrors.NotLength('2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_isupdating(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_isupdating(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'1 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_isupdating(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('1 '),SALT32.HygieneErrors.NotLength('0,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_iscurrent(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_iscurrent(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'1 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_iscurrent(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('1 '),SALT32.HygieneErrors.NotLength('0,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_did(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('10,9,12,11,0,8,7'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_did_score(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0145789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did_score(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0145789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did_score(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0145789 '),SALT32.HygieneErrors.NotLength('3,0,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_dt_first_seen(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_first_seen(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('8,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_dt_last_seen(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_last_seen(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('0,8'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_dt_vendor_last_reported(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_last_reported(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_vendor_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('8'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_dt_vendor_first_reported(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_first_reported(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('8'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_clean_phone(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_phone(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('0,10'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_clean_ssn(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_ssn(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('9,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_clean_dob(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_dob(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('8,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_title(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'MRS '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_title(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'MRS '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_title(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('MRS '),SALT32.HygieneErrors.NotLength('2,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_fname(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fname(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 12),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('5,6,7,4,8,1,9,3,10,11,0,2,12'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_mname(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mname(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 10),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT32.HygieneErrors.NotLength('1,0,5,4,6,3,7,8,9,2,10'),SALT32.HygieneErrors.NotWords('1,2'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_lname(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lname(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 20),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('6,7,5,8,4,9,10,3,11,12,13,14,15,16,2,17,18,20'),SALT32.HygieneErrors.NotWords('1,2'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_name_suffix(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ACDEIJLNRSTVXY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_suffix(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ACDEIJLNRSTVXY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ACDEIJLNRSTVXY '),SALT32.HygieneErrors.NotLength('0,2,3,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_name_score(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'012789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_score(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'012789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_score(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('012789 '),SALT32.HygieneErrors.NotLength('2,0,3'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_prim_range(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_range(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('4,3,5,2,0,1,6'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_predir(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_predir(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ENSW '),SALT32.HygieneErrors.NotLength('0,1,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_prim_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 4 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 5));
EXPORT InValidMessageFT_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('7,6,8,4,5,9,10,11,12,3,13,14,15,16,17,1,18,19,20,2,21,22,27,23,24'),SALT32.HygieneErrors.NotWords('1,2,3,4,5'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_addr_suffix(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEGHIKLNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addr_suffix(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEGHIKLNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ABCDEGHIKLNOPQRSTUVWXY '),SALT32.HygieneErrors.NotLength('2,3,0,4'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_postdir(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_postdir(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ENSW '),SALT32.HygieneErrors.NotLength('0,1,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_unit_desig(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'#ABCEFILMNOPRSTUX '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_unit_desig(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'#ABCEFILMNOPRSTUX '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 4),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('#ABCEFILMNOPRSTUX '),SALT32.HygieneErrors.NotLength('0,3,1,4'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_sec_range(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' -0123456789ABCDEFGHIJKLMNOPRSTUVWY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sec_range(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' -0123456789ABCDEFGHIJKLMNOPRSTUVWY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' -0123456789ABCDEFGHIJKLMNOPRSTUVWY '),SALT32.HygieneErrors.NotLength('0,1,3,2,4,5'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_p_city_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_p_city_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT32.HygieneErrors.NotLength('7,8,9,6,10,11,12,5,13,4,14,15,16,3,17,18,19,20'),SALT32.HygieneErrors.NotWords('1,2,3'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_v_city_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_v_city_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 22),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT32.HygieneErrors.NotLength('7,8,9,6,10,11,12,5,13,14,4,15,16,17,3,18,19,20,22'),SALT32.HygieneErrors.NotWords('1,2,3'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_st(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_st(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_st(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_zip(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('5'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_zip4(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip4(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('4,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_cart(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789BCHR '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cart(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789BCHR '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789BCHR '),SALT32.HygieneErrors.NotLength('4,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_cr_sort_sz(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'BCD '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cr_sort_sz(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'BCD '))),~(LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('BCD '),SALT32.HygieneErrors.NotLength('1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_lot(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('4,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_lot_order(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'AD '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot_order(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'AD '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('AD '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_dbpc(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dbpc(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('2,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_chk_digit(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_chk_digit(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_rec_type(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'DFHMPRS '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rec_type(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'DFHMPRS '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('DFHMPRS '),SALT32.HygieneErrors.NotLength('1,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_fips_county(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fips_county(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_county(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_county(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_county(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('3,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_geo_lat(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'.0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_lat(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'.0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_lat(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('.0123456789 '),SALT32.HygieneErrors.NotLength('9,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_geo_long(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'-.0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_long(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'-.0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_long(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('-.0123456789 '),SALT32.HygieneErrors.NotLength('10,11,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_msa(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_msa(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('4,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_geo_blk(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_blk(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('7,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_geo_match(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0145 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_match(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0145 '))),~(LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0145 '),SALT32.HygieneErrors.NotLength('1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_err_stat(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789ABCES '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_err_stat(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789ABCES '))),~(LENGTH(TRIM(s)) = 4),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789ABCES '),SALT32.HygieneErrors.NotLength('4'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_rawaid(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rawaid(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 13),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_rawaid(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('13'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_isdelete(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_isdelete(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'1 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_isdelete(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('1 '),SALT32.HygieneErrors.NotLength('0,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'record_type','first_name','middle_name','last_name','name_prefix','name_suffix_','perm_id','ssn','aka1','aka2','aka3','new_subject_flag','name_change_flag','address_change_flag','ssn_change_flag','file_since_date_change_flag','deceased_indicator_flag','dob_change_flag','phone_change_flag','filler2','gender','mfdu_indicator','file_since_date','house_number','street_direction','street_name','street_type','street_post_direction','unit_type','unit_number','cty','state','zip_code','zp4','address_standardization_indicator','date_address_reported','party_id','deceased_indicator','date_of_birth','date_of_birth_estimated_ind','phone','filler3','prepped_name','prepped_addr1','prepped_addr2','prepped_rec_type','isupdating','iscurrent','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','clean_phone','clean_ssn','clean_dob','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','isdelete');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'record_type' => 0,'first_name' => 1,'middle_name' => 2,'last_name' => 3,'name_prefix' => 4,'name_suffix_' => 5,'perm_id' => 6,'ssn' => 7,'aka1' => 8,'aka2' => 9,'aka3' => 10,'new_subject_flag' => 11,'name_change_flag' => 12,'address_change_flag' => 13,'ssn_change_flag' => 14,'file_since_date_change_flag' => 15,'deceased_indicator_flag' => 16,'dob_change_flag' => 17,'phone_change_flag' => 18,'filler2' => 19,'gender' => 20,'mfdu_indicator' => 21,'file_since_date' => 22,'house_number' => 23,'street_direction' => 24,'street_name' => 25,'street_type' => 26,'street_post_direction' => 27,'unit_type' => 28,'unit_number' => 29,'cty' => 30,'state' => 31,'zip_code' => 32,'zp4' => 33,'address_standardization_indicator' => 34,'date_address_reported' => 35,'party_id' => 36,'deceased_indicator' => 37,'date_of_birth' => 38,'date_of_birth_estimated_ind' => 39,'phone' => 40,'filler3' => 41,'prepped_name' => 42,'prepped_addr1' => 43,'prepped_addr2' => 44,'prepped_rec_type' => 45,'isupdating' => 46,'iscurrent' => 47,'did' => 48,'did_score' => 49,'dt_first_seen' => 50,'dt_last_seen' => 51,'dt_vendor_last_reported' => 52,'dt_vendor_first_reported' => 53,'clean_phone' => 54,'clean_ssn' => 55,'clean_dob' => 56,'title' => 57,'fname' => 58,'mname' => 59,'lname' => 60,'name_suffix' => 61,'name_score' => 62,'prim_range' => 63,'predir' => 64,'prim_name' => 65,'addr_suffix' => 66,'postdir' => 67,'unit_desig' => 68,'sec_range' => 69,'p_city_name' => 70,'v_city_name' => 71,'st' => 72,'zip' => 73,'zip4' => 74,'cart' => 75,'cr_sort_sz' => 76,'lot' => 77,'lot_order' => 78,'dbpc' => 79,'chk_digit' => 80,'rec_type' => 81,'fips_county' => 82,'county' => 83,'geo_lat' => 84,'geo_long' => 85,'msa' => 86,'geo_blk' => 87,'geo_match' => 88,'err_stat' => 89,'rawaid' => 90,'isdelete' => 91,0);
 
//Individual field level validation
 
EXPORT Make_record_type(SALT32.StrType s0) := MakeFT_record_type(s0);
EXPORT InValid_record_type(SALT32.StrType s) := InValidFT_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_record_type(wh);
 
EXPORT Make_first_name(SALT32.StrType s0) := MakeFT_first_name(s0);
EXPORT InValid_first_name(SALT32.StrType s) := InValidFT_first_name(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_first_name(wh);
 
EXPORT Make_middle_name(SALT32.StrType s0) := MakeFT_middle_name(s0);
EXPORT InValid_middle_name(SALT32.StrType s) := InValidFT_middle_name(s);
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := InValidMessageFT_middle_name(wh);
 
EXPORT Make_last_name(SALT32.StrType s0) := MakeFT_last_name(s0);
EXPORT InValid_last_name(SALT32.StrType s) := InValidFT_last_name(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_last_name(wh);
 
EXPORT Make_name_prefix(SALT32.StrType s0) := MakeFT_name_prefix(s0);
EXPORT InValid_name_prefix(SALT32.StrType s) := InValidFT_name_prefix(s);
EXPORT InValidMessage_name_prefix(UNSIGNED1 wh) := InValidMessageFT_name_prefix(wh);
 
EXPORT Make_name_suffix_(SALT32.StrType s0) := MakeFT_name_suffix_(s0);
EXPORT InValid_name_suffix_(SALT32.StrType s) := InValidFT_name_suffix_(s);
EXPORT InValidMessage_name_suffix_(UNSIGNED1 wh) := InValidMessageFT_name_suffix_(wh);
 
EXPORT Make_perm_id(SALT32.StrType s0) := MakeFT_perm_id(s0);
EXPORT InValid_perm_id(SALT32.StrType s) := InValidFT_perm_id(s);
EXPORT InValidMessage_perm_id(UNSIGNED1 wh) := InValidMessageFT_perm_id(wh);
 
EXPORT Make_ssn(SALT32.StrType s0) := MakeFT_ssn(s0);
EXPORT InValid_ssn(SALT32.StrType s) := InValidFT_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_ssn(wh);
 
EXPORT Make_aka1(SALT32.StrType s0) := MakeFT_aka1(s0);
EXPORT InValid_aka1(SALT32.StrType s) := InValidFT_aka1(s);
EXPORT InValidMessage_aka1(UNSIGNED1 wh) := InValidMessageFT_aka1(wh);
 
EXPORT Make_aka2(SALT32.StrType s0) := MakeFT_aka2(s0);
EXPORT InValid_aka2(SALT32.StrType s) := InValidFT_aka2(s);
EXPORT InValidMessage_aka2(UNSIGNED1 wh) := InValidMessageFT_aka2(wh);
 
EXPORT Make_aka3(SALT32.StrType s0) := MakeFT_aka3(s0);
EXPORT InValid_aka3(SALT32.StrType s) := InValidFT_aka3(s);
EXPORT InValidMessage_aka3(UNSIGNED1 wh) := InValidMessageFT_aka3(wh);
 
EXPORT Make_new_subject_flag(SALT32.StrType s0) := MakeFT_new_subject_flag(s0);
EXPORT InValid_new_subject_flag(SALT32.StrType s) := InValidFT_new_subject_flag(s);
EXPORT InValidMessage_new_subject_flag(UNSIGNED1 wh) := InValidMessageFT_new_subject_flag(wh);
 
EXPORT Make_name_change_flag(SALT32.StrType s0) := MakeFT_name_change_flag(s0);
EXPORT InValid_name_change_flag(SALT32.StrType s) := InValidFT_name_change_flag(s);
EXPORT InValidMessage_name_change_flag(UNSIGNED1 wh) := InValidMessageFT_name_change_flag(wh);
 
EXPORT Make_address_change_flag(SALT32.StrType s0) := MakeFT_address_change_flag(s0);
EXPORT InValid_address_change_flag(SALT32.StrType s) := InValidFT_address_change_flag(s);
EXPORT InValidMessage_address_change_flag(UNSIGNED1 wh) := InValidMessageFT_address_change_flag(wh);
 
EXPORT Make_ssn_change_flag(SALT32.StrType s0) := MakeFT_ssn_change_flag(s0);
EXPORT InValid_ssn_change_flag(SALT32.StrType s) := InValidFT_ssn_change_flag(s);
EXPORT InValidMessage_ssn_change_flag(UNSIGNED1 wh) := InValidMessageFT_ssn_change_flag(wh);
 
EXPORT Make_file_since_date_change_flag(SALT32.StrType s0) := MakeFT_file_since_date_change_flag(s0);
EXPORT InValid_file_since_date_change_flag(SALT32.StrType s) := InValidFT_file_since_date_change_flag(s);
EXPORT InValidMessage_file_since_date_change_flag(UNSIGNED1 wh) := InValidMessageFT_file_since_date_change_flag(wh);
 
EXPORT Make_deceased_indicator_flag(SALT32.StrType s0) := MakeFT_deceased_indicator_flag(s0);
EXPORT InValid_deceased_indicator_flag(SALT32.StrType s) := InValidFT_deceased_indicator_flag(s);
EXPORT InValidMessage_deceased_indicator_flag(UNSIGNED1 wh) := InValidMessageFT_deceased_indicator_flag(wh);
 
EXPORT Make_dob_change_flag(SALT32.StrType s0) := MakeFT_dob_change_flag(s0);
EXPORT InValid_dob_change_flag(SALT32.StrType s) := InValidFT_dob_change_flag(s);
EXPORT InValidMessage_dob_change_flag(UNSIGNED1 wh) := InValidMessageFT_dob_change_flag(wh);
 
EXPORT Make_phone_change_flag(SALT32.StrType s0) := MakeFT_phone_change_flag(s0);
EXPORT InValid_phone_change_flag(SALT32.StrType s) := InValidFT_phone_change_flag(s);
EXPORT InValidMessage_phone_change_flag(UNSIGNED1 wh) := InValidMessageFT_phone_change_flag(wh);
 
EXPORT Make_filler2(SALT32.StrType s0) := MakeFT_filler2(s0);
EXPORT InValid_filler2(SALT32.StrType s) := InValidFT_filler2(s);
EXPORT InValidMessage_filler2(UNSIGNED1 wh) := InValidMessageFT_filler2(wh);
 
EXPORT Make_gender(SALT32.StrType s0) := MakeFT_gender(s0);
EXPORT InValid_gender(SALT32.StrType s) := InValidFT_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_gender(wh);
 
EXPORT Make_mfdu_indicator(SALT32.StrType s0) := MakeFT_mfdu_indicator(s0);
EXPORT InValid_mfdu_indicator(SALT32.StrType s) := InValidFT_mfdu_indicator(s);
EXPORT InValidMessage_mfdu_indicator(UNSIGNED1 wh) := InValidMessageFT_mfdu_indicator(wh);
 
EXPORT Make_file_since_date(SALT32.StrType s0) := MakeFT_file_since_date(s0);
EXPORT InValid_file_since_date(SALT32.StrType s) := InValidFT_file_since_date(s);
EXPORT InValidMessage_file_since_date(UNSIGNED1 wh) := InValidMessageFT_file_since_date(wh);
 
EXPORT Make_house_number(SALT32.StrType s0) := MakeFT_house_number(s0);
EXPORT InValid_house_number(SALT32.StrType s) := InValidFT_house_number(s);
EXPORT InValidMessage_house_number(UNSIGNED1 wh) := InValidMessageFT_house_number(wh);
 
EXPORT Make_street_direction(SALT32.StrType s0) := MakeFT_street_direction(s0);
EXPORT InValid_street_direction(SALT32.StrType s) := InValidFT_street_direction(s);
EXPORT InValidMessage_street_direction(UNSIGNED1 wh) := InValidMessageFT_street_direction(wh);
 
EXPORT Make_street_name(SALT32.StrType s0) := MakeFT_street_name(s0);
EXPORT InValid_street_name(SALT32.StrType s) := InValidFT_street_name(s);
EXPORT InValidMessage_street_name(UNSIGNED1 wh) := InValidMessageFT_street_name(wh);
 
EXPORT Make_street_type(SALT32.StrType s0) := MakeFT_street_type(s0);
EXPORT InValid_street_type(SALT32.StrType s) := InValidFT_street_type(s);
EXPORT InValidMessage_street_type(UNSIGNED1 wh) := InValidMessageFT_street_type(wh);
 
EXPORT Make_street_post_direction(SALT32.StrType s0) := MakeFT_street_post_direction(s0);
EXPORT InValid_street_post_direction(SALT32.StrType s) := InValidFT_street_post_direction(s);
EXPORT InValidMessage_street_post_direction(UNSIGNED1 wh) := InValidMessageFT_street_post_direction(wh);
 
EXPORT Make_unit_type(SALT32.StrType s0) := MakeFT_unit_type(s0);
EXPORT InValid_unit_type(SALT32.StrType s) := InValidFT_unit_type(s);
EXPORT InValidMessage_unit_type(UNSIGNED1 wh) := InValidMessageFT_unit_type(wh);
 
EXPORT Make_unit_number(SALT32.StrType s0) := MakeFT_unit_number(s0);
EXPORT InValid_unit_number(SALT32.StrType s) := InValidFT_unit_number(s);
EXPORT InValidMessage_unit_number(UNSIGNED1 wh) := InValidMessageFT_unit_number(wh);
 
EXPORT Make_cty(SALT32.StrType s0) := MakeFT_cty(s0);
EXPORT InValid_cty(SALT32.StrType s) := InValidFT_cty(s);
EXPORT InValidMessage_cty(UNSIGNED1 wh) := InValidMessageFT_cty(wh);
 
EXPORT Make_state(SALT32.StrType s0) := MakeFT_state(s0);
EXPORT InValid_state(SALT32.StrType s) := InValidFT_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_state(wh);
 
EXPORT Make_zip_code(SALT32.StrType s0) := MakeFT_zip_code(s0);
EXPORT InValid_zip_code(SALT32.StrType s) := InValidFT_zip_code(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_zip_code(wh);
 
EXPORT Make_zp4(SALT32.StrType s0) := MakeFT_zp4(s0);
EXPORT InValid_zp4(SALT32.StrType s) := InValidFT_zp4(s);
EXPORT InValidMessage_zp4(UNSIGNED1 wh) := InValidMessageFT_zp4(wh);
 
EXPORT Make_address_standardization_indicator(SALT32.StrType s0) := MakeFT_address_standardization_indicator(s0);
EXPORT InValid_address_standardization_indicator(SALT32.StrType s) := InValidFT_address_standardization_indicator(s);
EXPORT InValidMessage_address_standardization_indicator(UNSIGNED1 wh) := InValidMessageFT_address_standardization_indicator(wh);
 
EXPORT Make_date_address_reported(SALT32.StrType s0) := MakeFT_date_address_reported(s0);
EXPORT InValid_date_address_reported(SALT32.StrType s) := InValidFT_date_address_reported(s);
EXPORT InValidMessage_date_address_reported(UNSIGNED1 wh) := InValidMessageFT_date_address_reported(wh);
 
EXPORT Make_party_id(SALT32.StrType s0) := MakeFT_party_id(s0);
EXPORT InValid_party_id(SALT32.StrType s) := InValidFT_party_id(s);
EXPORT InValidMessage_party_id(UNSIGNED1 wh) := InValidMessageFT_party_id(wh);
 
EXPORT Make_deceased_indicator(SALT32.StrType s0) := MakeFT_deceased_indicator(s0);
EXPORT InValid_deceased_indicator(SALT32.StrType s) := InValidFT_deceased_indicator(s);
EXPORT InValidMessage_deceased_indicator(UNSIGNED1 wh) := InValidMessageFT_deceased_indicator(wh);
 
EXPORT Make_date_of_birth(SALT32.StrType s0) := MakeFT_date_of_birth(s0);
EXPORT InValid_date_of_birth(SALT32.StrType s) := InValidFT_date_of_birth(s);
EXPORT InValidMessage_date_of_birth(UNSIGNED1 wh) := InValidMessageFT_date_of_birth(wh);
 
EXPORT Make_date_of_birth_estimated_ind(SALT32.StrType s0) := MakeFT_date_of_birth_estimated_ind(s0);
EXPORT InValid_date_of_birth_estimated_ind(SALT32.StrType s) := InValidFT_date_of_birth_estimated_ind(s);
EXPORT InValidMessage_date_of_birth_estimated_ind(UNSIGNED1 wh) := InValidMessageFT_date_of_birth_estimated_ind(wh);
 
EXPORT Make_phone(SALT32.StrType s0) := MakeFT_phone(s0);
EXPORT InValid_phone(SALT32.StrType s) := InValidFT_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_phone(wh);
 
EXPORT Make_filler3(SALT32.StrType s0) := MakeFT_filler3(s0);
EXPORT InValid_filler3(SALT32.StrType s) := InValidFT_filler3(s);
EXPORT InValidMessage_filler3(UNSIGNED1 wh) := InValidMessageFT_filler3(wh);
 
EXPORT Make_prepped_name(SALT32.StrType s0) := MakeFT_prepped_name(s0);
EXPORT InValid_prepped_name(SALT32.StrType s) := InValidFT_prepped_name(s);
EXPORT InValidMessage_prepped_name(UNSIGNED1 wh) := InValidMessageFT_prepped_name(wh);
 
EXPORT Make_prepped_addr1(SALT32.StrType s0) := MakeFT_prepped_addr1(s0);
EXPORT InValid_prepped_addr1(SALT32.StrType s) := InValidFT_prepped_addr1(s);
EXPORT InValidMessage_prepped_addr1(UNSIGNED1 wh) := InValidMessageFT_prepped_addr1(wh);
 
EXPORT Make_prepped_addr2(SALT32.StrType s0) := MakeFT_prepped_addr2(s0);
EXPORT InValid_prepped_addr2(SALT32.StrType s) := InValidFT_prepped_addr2(s);
EXPORT InValidMessage_prepped_addr2(UNSIGNED1 wh) := InValidMessageFT_prepped_addr2(wh);
 
EXPORT Make_prepped_rec_type(SALT32.StrType s0) := MakeFT_prepped_rec_type(s0);
EXPORT InValid_prepped_rec_type(SALT32.StrType s) := InValidFT_prepped_rec_type(s);
EXPORT InValidMessage_prepped_rec_type(UNSIGNED1 wh) := InValidMessageFT_prepped_rec_type(wh);
 
EXPORT Make_isupdating(SALT32.StrType s0) := MakeFT_isupdating(s0);
EXPORT InValid_isupdating(SALT32.StrType s) := InValidFT_isupdating(s);
EXPORT InValidMessage_isupdating(UNSIGNED1 wh) := InValidMessageFT_isupdating(wh);
 
EXPORT Make_iscurrent(SALT32.StrType s0) := MakeFT_iscurrent(s0);
EXPORT InValid_iscurrent(SALT32.StrType s) := InValidFT_iscurrent(s);
EXPORT InValidMessage_iscurrent(UNSIGNED1 wh) := InValidMessageFT_iscurrent(wh);
 
EXPORT Make_did(SALT32.StrType s0) := MakeFT_did(s0);
EXPORT InValid_did(SALT32.StrType s) := InValidFT_did(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_did(wh);
 
EXPORT Make_did_score(SALT32.StrType s0) := MakeFT_did_score(s0);
EXPORT InValid_did_score(SALT32.StrType s) := InValidFT_did_score(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_did_score(wh);
 
EXPORT Make_dt_first_seen(SALT32.StrType s0) := MakeFT_dt_first_seen(s0);
EXPORT InValid_dt_first_seen(SALT32.StrType s) := InValidFT_dt_first_seen(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_dt_first_seen(wh);
 
EXPORT Make_dt_last_seen(SALT32.StrType s0) := MakeFT_dt_last_seen(s0);
EXPORT InValid_dt_last_seen(SALT32.StrType s) := InValidFT_dt_last_seen(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_dt_last_seen(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT32.StrType s0) := MakeFT_dt_vendor_last_reported(s0);
EXPORT InValid_dt_vendor_last_reported(SALT32.StrType s) := InValidFT_dt_vendor_last_reported(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_last_reported(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT32.StrType s0) := MakeFT_dt_vendor_first_reported(s0);
EXPORT InValid_dt_vendor_first_reported(SALT32.StrType s) := InValidFT_dt_vendor_first_reported(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_first_reported(wh);
 
EXPORT Make_clean_phone(SALT32.StrType s0) := MakeFT_clean_phone(s0);
EXPORT InValid_clean_phone(SALT32.StrType s) := InValidFT_clean_phone(s);
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := InValidMessageFT_clean_phone(wh);
 
EXPORT Make_clean_ssn(SALT32.StrType s0) := MakeFT_clean_ssn(s0);
EXPORT InValid_clean_ssn(SALT32.StrType s) := InValidFT_clean_ssn(s);
EXPORT InValidMessage_clean_ssn(UNSIGNED1 wh) := InValidMessageFT_clean_ssn(wh);
 
EXPORT Make_clean_dob(SALT32.StrType s0) := MakeFT_clean_dob(s0);
EXPORT InValid_clean_dob(SALT32.StrType s) := InValidFT_clean_dob(s);
EXPORT InValidMessage_clean_dob(UNSIGNED1 wh) := InValidMessageFT_clean_dob(wh);
 
EXPORT Make_title(SALT32.StrType s0) := MakeFT_title(s0);
EXPORT InValid_title(SALT32.StrType s) := InValidFT_title(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_title(wh);
 
EXPORT Make_fname(SALT32.StrType s0) := MakeFT_fname(s0);
EXPORT InValid_fname(SALT32.StrType s) := InValidFT_fname(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_fname(wh);
 
EXPORT Make_mname(SALT32.StrType s0) := MakeFT_mname(s0);
EXPORT InValid_mname(SALT32.StrType s) := InValidFT_mname(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_mname(wh);
 
EXPORT Make_lname(SALT32.StrType s0) := MakeFT_lname(s0);
EXPORT InValid_lname(SALT32.StrType s) := InValidFT_lname(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_lname(wh);
 
EXPORT Make_name_suffix(SALT32.StrType s0) := MakeFT_name_suffix(s0);
EXPORT InValid_name_suffix(SALT32.StrType s) := InValidFT_name_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_name_suffix(wh);
 
EXPORT Make_name_score(SALT32.StrType s0) := MakeFT_name_score(s0);
EXPORT InValid_name_score(SALT32.StrType s) := InValidFT_name_score(s);
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := InValidMessageFT_name_score(wh);
 
EXPORT Make_prim_range(SALT32.StrType s0) := MakeFT_prim_range(s0);
EXPORT InValid_prim_range(SALT32.StrType s) := InValidFT_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_prim_range(wh);
 
EXPORT Make_predir(SALT32.StrType s0) := MakeFT_predir(s0);
EXPORT InValid_predir(SALT32.StrType s) := InValidFT_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_predir(wh);
 
EXPORT Make_prim_name(SALT32.StrType s0) := MakeFT_prim_name(s0);
EXPORT InValid_prim_name(SALT32.StrType s) := InValidFT_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_prim_name(wh);
 
EXPORT Make_addr_suffix(SALT32.StrType s0) := MakeFT_addr_suffix(s0);
EXPORT InValid_addr_suffix(SALT32.StrType s) := InValidFT_addr_suffix(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_addr_suffix(wh);
 
EXPORT Make_postdir(SALT32.StrType s0) := MakeFT_postdir(s0);
EXPORT InValid_postdir(SALT32.StrType s) := InValidFT_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_postdir(wh);
 
EXPORT Make_unit_desig(SALT32.StrType s0) := MakeFT_unit_desig(s0);
EXPORT InValid_unit_desig(SALT32.StrType s) := InValidFT_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_unit_desig(wh);
 
EXPORT Make_sec_range(SALT32.StrType s0) := MakeFT_sec_range(s0);
EXPORT InValid_sec_range(SALT32.StrType s) := InValidFT_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_sec_range(wh);
 
EXPORT Make_p_city_name(SALT32.StrType s0) := MakeFT_p_city_name(s0);
EXPORT InValid_p_city_name(SALT32.StrType s) := InValidFT_p_city_name(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_p_city_name(wh);
 
EXPORT Make_v_city_name(SALT32.StrType s0) := MakeFT_v_city_name(s0);
EXPORT InValid_v_city_name(SALT32.StrType s) := InValidFT_v_city_name(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_v_city_name(wh);
 
EXPORT Make_st(SALT32.StrType s0) := MakeFT_st(s0);
EXPORT InValid_st(SALT32.StrType s) := InValidFT_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_st(wh);
 
EXPORT Make_zip(SALT32.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT32.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);
 
EXPORT Make_zip4(SALT32.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT32.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);
 
EXPORT Make_cart(SALT32.StrType s0) := MakeFT_cart(s0);
EXPORT InValid_cart(SALT32.StrType s) := InValidFT_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_cart(wh);
 
EXPORT Make_cr_sort_sz(SALT32.StrType s0) := MakeFT_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT32.StrType s) := InValidFT_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_cr_sort_sz(wh);
 
EXPORT Make_lot(SALT32.StrType s0) := MakeFT_lot(s0);
EXPORT InValid_lot(SALT32.StrType s) := InValidFT_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_lot(wh);
 
EXPORT Make_lot_order(SALT32.StrType s0) := MakeFT_lot_order(s0);
EXPORT InValid_lot_order(SALT32.StrType s) := InValidFT_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_lot_order(wh);
 
EXPORT Make_dbpc(SALT32.StrType s0) := MakeFT_dbpc(s0);
EXPORT InValid_dbpc(SALT32.StrType s) := InValidFT_dbpc(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_dbpc(wh);
 
EXPORT Make_chk_digit(SALT32.StrType s0) := MakeFT_chk_digit(s0);
EXPORT InValid_chk_digit(SALT32.StrType s) := InValidFT_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_chk_digit(wh);
 
EXPORT Make_rec_type(SALT32.StrType s0) := MakeFT_rec_type(s0);
EXPORT InValid_rec_type(SALT32.StrType s) := InValidFT_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_rec_type(wh);
 
EXPORT Make_fips_county(SALT32.StrType s0) := MakeFT_fips_county(s0);
EXPORT InValid_fips_county(SALT32.StrType s) := InValidFT_fips_county(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_fips_county(wh);
 
EXPORT Make_county(SALT32.StrType s0) := MakeFT_county(s0);
EXPORT InValid_county(SALT32.StrType s) := InValidFT_county(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_county(wh);
 
EXPORT Make_geo_lat(SALT32.StrType s0) := MakeFT_geo_lat(s0);
EXPORT InValid_geo_lat(SALT32.StrType s) := InValidFT_geo_lat(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_geo_lat(wh);
 
EXPORT Make_geo_long(SALT32.StrType s0) := MakeFT_geo_long(s0);
EXPORT InValid_geo_long(SALT32.StrType s) := InValidFT_geo_long(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_geo_long(wh);
 
EXPORT Make_msa(SALT32.StrType s0) := MakeFT_msa(s0);
EXPORT InValid_msa(SALT32.StrType s) := InValidFT_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_msa(wh);
 
EXPORT Make_geo_blk(SALT32.StrType s0) := MakeFT_geo_blk(s0);
EXPORT InValid_geo_blk(SALT32.StrType s) := InValidFT_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_geo_blk(wh);
 
EXPORT Make_geo_match(SALT32.StrType s0) := MakeFT_geo_match(s0);
EXPORT InValid_geo_match(SALT32.StrType s) := InValidFT_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_geo_match(wh);
 
EXPORT Make_err_stat(SALT32.StrType s0) := MakeFT_err_stat(s0);
EXPORT InValid_err_stat(SALT32.StrType s) := InValidFT_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_err_stat(wh);
 
EXPORT Make_rawaid(SALT32.StrType s0) := MakeFT_rawaid(s0);
EXPORT InValid_rawaid(SALT32.StrType s) := InValidFT_rawaid(s);
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := InValidMessageFT_rawaid(wh);
 
EXPORT Make_isdelete(SALT32.StrType s0) := MakeFT_isdelete(s0);
EXPORT InValid_isdelete(SALT32.StrType s) := InValidFT_isdelete(s);
EXPORT InValidMessage_isdelete(UNSIGNED1 wh) := InValidMessageFT_isdelete(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,Scrubs_Transunion_Monthly;
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
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_name_prefix;
    BOOLEAN Diff_name_suffix_;
    BOOLEAN Diff_perm_id;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_aka1;
    BOOLEAN Diff_aka2;
    BOOLEAN Diff_aka3;
    BOOLEAN Diff_new_subject_flag;
    BOOLEAN Diff_name_change_flag;
    BOOLEAN Diff_address_change_flag;
    BOOLEAN Diff_ssn_change_flag;
    BOOLEAN Diff_file_since_date_change_flag;
    BOOLEAN Diff_deceased_indicator_flag;
    BOOLEAN Diff_dob_change_flag;
    BOOLEAN Diff_phone_change_flag;
    BOOLEAN Diff_filler2;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_mfdu_indicator;
    BOOLEAN Diff_file_since_date;
    BOOLEAN Diff_house_number;
    BOOLEAN Diff_street_direction;
    BOOLEAN Diff_street_name;
    BOOLEAN Diff_street_type;
    BOOLEAN Diff_street_post_direction;
    BOOLEAN Diff_unit_type;
    BOOLEAN Diff_unit_number;
    BOOLEAN Diff_cty;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_zp4;
    BOOLEAN Diff_address_standardization_indicator;
    BOOLEAN Diff_date_address_reported;
    BOOLEAN Diff_party_id;
    BOOLEAN Diff_deceased_indicator;
    BOOLEAN Diff_date_of_birth;
    BOOLEAN Diff_date_of_birth_estimated_ind;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_filler3;
    BOOLEAN Diff_prepped_name;
    BOOLEAN Diff_prepped_addr1;
    BOOLEAN Diff_prepped_addr2;
    BOOLEAN Diff_prepped_rec_type;
    BOOLEAN Diff_isupdating;
    BOOLEAN Diff_iscurrent;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_clean_ssn;
    BOOLEAN Diff_clean_dob;
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
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_isdelete;
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_name_prefix := le.name_prefix <> ri.name_prefix;
    SELF.Diff_name_suffix_ := le.name_suffix_ <> ri.name_suffix_;
    SELF.Diff_perm_id := le.perm_id <> ri.perm_id;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_aka1 := le.aka1 <> ri.aka1;
    SELF.Diff_aka2 := le.aka2 <> ri.aka2;
    SELF.Diff_aka3 := le.aka3 <> ri.aka3;
    SELF.Diff_new_subject_flag := le.new_subject_flag <> ri.new_subject_flag;
    SELF.Diff_name_change_flag := le.name_change_flag <> ri.name_change_flag;
    SELF.Diff_address_change_flag := le.address_change_flag <> ri.address_change_flag;
    SELF.Diff_ssn_change_flag := le.ssn_change_flag <> ri.ssn_change_flag;
    SELF.Diff_file_since_date_change_flag := le.file_since_date_change_flag <> ri.file_since_date_change_flag;
    SELF.Diff_deceased_indicator_flag := le.deceased_indicator_flag <> ri.deceased_indicator_flag;
    SELF.Diff_dob_change_flag := le.dob_change_flag <> ri.dob_change_flag;
    SELF.Diff_phone_change_flag := le.phone_change_flag <> ri.phone_change_flag;
    SELF.Diff_filler2 := le.filler2 <> ri.filler2;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_mfdu_indicator := le.mfdu_indicator <> ri.mfdu_indicator;
    SELF.Diff_file_since_date := le.file_since_date <> ri.file_since_date;
    SELF.Diff_house_number := le.house_number <> ri.house_number;
    SELF.Diff_street_direction := le.street_direction <> ri.street_direction;
    SELF.Diff_street_name := le.street_name <> ri.street_name;
    SELF.Diff_street_type := le.street_type <> ri.street_type;
    SELF.Diff_street_post_direction := le.street_post_direction <> ri.street_post_direction;
    SELF.Diff_unit_type := le.unit_type <> ri.unit_type;
    SELF.Diff_unit_number := le.unit_number <> ri.unit_number;
    SELF.Diff_cty := le.cty <> ri.cty;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_zp4 := le.zp4 <> ri.zp4;
    SELF.Diff_address_standardization_indicator := le.address_standardization_indicator <> ri.address_standardization_indicator;
    SELF.Diff_date_address_reported := le.date_address_reported <> ri.date_address_reported;
    SELF.Diff_party_id := le.party_id <> ri.party_id;
    SELF.Diff_deceased_indicator := le.deceased_indicator <> ri.deceased_indicator;
    SELF.Diff_date_of_birth := le.date_of_birth <> ri.date_of_birth;
    SELF.Diff_date_of_birth_estimated_ind := le.date_of_birth_estimated_ind <> ri.date_of_birth_estimated_ind;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_filler3 := le.filler3 <> ri.filler3;
    SELF.Diff_prepped_name := le.prepped_name <> ri.prepped_name;
    SELF.Diff_prepped_addr1 := le.prepped_addr1 <> ri.prepped_addr1;
    SELF.Diff_prepped_addr2 := le.prepped_addr2 <> ri.prepped_addr2;
    SELF.Diff_prepped_rec_type := le.prepped_rec_type <> ri.prepped_rec_type;
    SELF.Diff_isupdating := le.isupdating <> ri.isupdating;
    SELF.Diff_iscurrent := le.iscurrent <> ri.iscurrent;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_clean_ssn := le.clean_ssn <> ri.clean_ssn;
    SELF.Diff_clean_dob := le.clean_dob <> ri.clean_dob;
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
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_isdelete := le.isdelete <> ri.isdelete;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_name_prefix,1,0)+ IF( SELF.Diff_name_suffix_,1,0)+ IF( SELF.Diff_perm_id,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_aka1,1,0)+ IF( SELF.Diff_aka2,1,0)+ IF( SELF.Diff_aka3,1,0)+ IF( SELF.Diff_new_subject_flag,1,0)+ IF( SELF.Diff_name_change_flag,1,0)+ IF( SELF.Diff_address_change_flag,1,0)+ IF( SELF.Diff_ssn_change_flag,1,0)+ IF( SELF.Diff_file_since_date_change_flag,1,0)+ IF( SELF.Diff_deceased_indicator_flag,1,0)+ IF( SELF.Diff_dob_change_flag,1,0)+ IF( SELF.Diff_phone_change_flag,1,0)+ IF( SELF.Diff_filler2,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_mfdu_indicator,1,0)+ IF( SELF.Diff_file_since_date,1,0)+ IF( SELF.Diff_house_number,1,0)+ IF( SELF.Diff_street_direction,1,0)+ IF( SELF.Diff_street_name,1,0)+ IF( SELF.Diff_street_type,1,0)+ IF( SELF.Diff_street_post_direction,1,0)+ IF( SELF.Diff_unit_type,1,0)+ IF( SELF.Diff_unit_number,1,0)+ IF( SELF.Diff_cty,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_zp4,1,0)+ IF( SELF.Diff_address_standardization_indicator,1,0)+ IF( SELF.Diff_date_address_reported,1,0)+ IF( SELF.Diff_party_id,1,0)+ IF( SELF.Diff_deceased_indicator,1,0)+ IF( SELF.Diff_date_of_birth,1,0)+ IF( SELF.Diff_date_of_birth_estimated_ind,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_filler3,1,0)+ IF( SELF.Diff_prepped_name,1,0)+ IF( SELF.Diff_prepped_addr1,1,0)+ IF( SELF.Diff_prepped_addr2,1,0)+ IF( SELF.Diff_prepped_rec_type,1,0)+ IF( SELF.Diff_isupdating,1,0)+ IF( SELF.Diff_iscurrent,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_clean_ssn,1,0)+ IF( SELF.Diff_clean_dob,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_isdelete,1,0);
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
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_name_prefix := COUNT(GROUP,%Closest%.Diff_name_prefix);
    Count_Diff_name_suffix_ := COUNT(GROUP,%Closest%.Diff_name_suffix_);
    Count_Diff_perm_id := COUNT(GROUP,%Closest%.Diff_perm_id);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_aka1 := COUNT(GROUP,%Closest%.Diff_aka1);
    Count_Diff_aka2 := COUNT(GROUP,%Closest%.Diff_aka2);
    Count_Diff_aka3 := COUNT(GROUP,%Closest%.Diff_aka3);
    Count_Diff_new_subject_flag := COUNT(GROUP,%Closest%.Diff_new_subject_flag);
    Count_Diff_name_change_flag := COUNT(GROUP,%Closest%.Diff_name_change_flag);
    Count_Diff_address_change_flag := COUNT(GROUP,%Closest%.Diff_address_change_flag);
    Count_Diff_ssn_change_flag := COUNT(GROUP,%Closest%.Diff_ssn_change_flag);
    Count_Diff_file_since_date_change_flag := COUNT(GROUP,%Closest%.Diff_file_since_date_change_flag);
    Count_Diff_deceased_indicator_flag := COUNT(GROUP,%Closest%.Diff_deceased_indicator_flag);
    Count_Diff_dob_change_flag := COUNT(GROUP,%Closest%.Diff_dob_change_flag);
    Count_Diff_phone_change_flag := COUNT(GROUP,%Closest%.Diff_phone_change_flag);
    Count_Diff_filler2 := COUNT(GROUP,%Closest%.Diff_filler2);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_mfdu_indicator := COUNT(GROUP,%Closest%.Diff_mfdu_indicator);
    Count_Diff_file_since_date := COUNT(GROUP,%Closest%.Diff_file_since_date);
    Count_Diff_house_number := COUNT(GROUP,%Closest%.Diff_house_number);
    Count_Diff_street_direction := COUNT(GROUP,%Closest%.Diff_street_direction);
    Count_Diff_street_name := COUNT(GROUP,%Closest%.Diff_street_name);
    Count_Diff_street_type := COUNT(GROUP,%Closest%.Diff_street_type);
    Count_Diff_street_post_direction := COUNT(GROUP,%Closest%.Diff_street_post_direction);
    Count_Diff_unit_type := COUNT(GROUP,%Closest%.Diff_unit_type);
    Count_Diff_unit_number := COUNT(GROUP,%Closest%.Diff_unit_number);
    Count_Diff_cty := COUNT(GROUP,%Closest%.Diff_cty);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_zp4 := COUNT(GROUP,%Closest%.Diff_zp4);
    Count_Diff_address_standardization_indicator := COUNT(GROUP,%Closest%.Diff_address_standardization_indicator);
    Count_Diff_date_address_reported := COUNT(GROUP,%Closest%.Diff_date_address_reported);
    Count_Diff_party_id := COUNT(GROUP,%Closest%.Diff_party_id);
    Count_Diff_deceased_indicator := COUNT(GROUP,%Closest%.Diff_deceased_indicator);
    Count_Diff_date_of_birth := COUNT(GROUP,%Closest%.Diff_date_of_birth);
    Count_Diff_date_of_birth_estimated_ind := COUNT(GROUP,%Closest%.Diff_date_of_birth_estimated_ind);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_filler3 := COUNT(GROUP,%Closest%.Diff_filler3);
    Count_Diff_prepped_name := COUNT(GROUP,%Closest%.Diff_prepped_name);
    Count_Diff_prepped_addr1 := COUNT(GROUP,%Closest%.Diff_prepped_addr1);
    Count_Diff_prepped_addr2 := COUNT(GROUP,%Closest%.Diff_prepped_addr2);
    Count_Diff_prepped_rec_type := COUNT(GROUP,%Closest%.Diff_prepped_rec_type);
    Count_Diff_isupdating := COUNT(GROUP,%Closest%.Diff_isupdating);
    Count_Diff_iscurrent := COUNT(GROUP,%Closest%.Diff_iscurrent);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_clean_ssn := COUNT(GROUP,%Closest%.Diff_clean_ssn);
    Count_Diff_clean_dob := COUNT(GROUP,%Closest%.Diff_clean_dob);
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
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_isdelete := COUNT(GROUP,%Closest%.Diff_isdelete);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
