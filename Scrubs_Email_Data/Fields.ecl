IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alnum','invalid_name','invalid_numeric','invalid_address','invalid_dir','invalid_state','invalid_zip','invalid_date','invalid_dob','invalid_ssn','invalid_activecode','invalid_source','invalid_email','invalid_blank');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alnum' => 2,'invalid_name' => 3,'invalid_numeric' => 4,'invalid_address' => 5,'invalid_dir' => 6,'invalid_state' => 7,'invalid_zip' => 8,'invalid_date' => 9,'invalid_dob' => 10,'invalid_ssn' => 11,'invalid_activecode' => 12,'invalid_source' => 13,'invalid_email' => 14,'invalid_blank' => 15,0);
EXPORT MakeFT_invalid_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓØËÈÉâãáåäïöøéü -\'/.'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -\'/.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓØËÈÉâãáåäïöøéü -\'/.'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓØËÈÉâãáåäïöøéü -\'/.'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alnum(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -/'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alnum(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -/'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alnum(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -/'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓØËÈÉâãáåäïöøéü0123456789\' -`,&\\/.:;_+'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -`,&\\/.:;_+',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓØËÈÉâãáåäïöøéü0123456789\' -`,&\\/.:;_+'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓØËÈÉâãáåäïöøéü0123456789\' -`,&\\/.:;_+'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_numeric(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789 -'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_numeric(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789 -'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789 -'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_address(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓøØËÈÉäïöéü0123456789\' -&/\\#.;,'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -&/\\#.;,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓøØËÈÉäïöéü0123456789\' -&/\\#.;,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓøØËÈÉäïöéü0123456789\' -&/\\#.;,'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_dir(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dir(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['N','NW','NE','S','SE','SW','E','W',' ']);
EXPORT InValidMessageFT_invalid_dir(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('N|NW|NE|S|SE|SW|E|W| '),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT30.HygieneErrors.NotLength('5,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789 '),SALT30.HygieneErrors.NotLength('8,6,4,1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_dob(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_dob(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789 '),SALT30.HygieneErrors.NotLength('8,4,1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_ssn(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ssn(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('9,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_activecode(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_activecode(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['A','I',' '],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_activecode(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('A|I| '),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_source(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['T$','TM','SC','IB','M1','IM','!I','DG','W@','AW','AO','ET']);
EXPORT InValidMessageFT_invalid_source(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('T$|TM|SC|IB|M1|IM|!I|DG|W@|AW|AO|ET|AN|RS'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_email(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -@&._!?/'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -@&._!?/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_email(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -@&._!?/'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -@&._!?/'),SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_blank(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_blank(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'clean_email','append_email_username','append_domain','append_domain_type','append_domain_root','append_domain_ext','append_is_tld_state','append_is_tld_generic','append_is_tld_country','append_is_valid_domain_ext','email_rec_key','email_src','rec_src_all','email_src_all','email_src_num','num_email_per_did','num_did_per_email','orig_pmghousehold_id','orig_pmgindividual_id','orig_first_name','orig_last_name','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_email','orig_ip','orig_login_date','orig_site','orig_e360_id','orig_teramedia_id','did','did_score','did_type','is_did_prop','hhid','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','append_rawaid','best_ssn','best_dob','process_date','activecode','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','current_rec');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'clean_email' => 1,'append_email_username' => 2,'append_domain' => 3,'append_domain_type' => 4,'append_domain_root' => 5,'append_domain_ext' => 6,'append_is_tld_state' => 7,'append_is_tld_generic' => 8,'append_is_tld_country' => 9,'append_is_valid_domain_ext' => 10,'email_rec_key' => 11,'email_src' => 12,'rec_src_all' => 13,'email_src_all' => 14,'email_src_num' => 15,'num_email_per_did' => 16,'num_did_per_email' => 17,'orig_pmghousehold_id' => 18,'orig_pmgindividual_id' => 19,'orig_first_name' => 20,'orig_last_name' => 21,'orig_address' => 22,'orig_city' => 23,'orig_state' => 24,'orig_zip' => 25,'orig_zip4' => 26,'orig_email' => 27,'orig_ip' => 28,'orig_login_date' => 29,'orig_site' => 30,'orig_e360_id' => 31,'orig_teramedia_id' => 32,'did' => 33,'did_score' => 34,'did_type' => 35,'is_did_prop' => 36,'hhid' => 37,'title' => 38,'fname' => 39,'mname' => 40,'lname' => 41,'name_suffix' => 42,'name_score' => 43,'prim_range' => 44,'predir' => 45,'prim_name' => 46,'addr_suffix' => 47,'postdir' => 48,'unit_desig' => 49,'sec_range' => 50,'p_city_name' => 51,'v_city_name' => 52,'st' => 53,'zip' => 54,'zip4' => 55,'cart' => 56,'cr_sort_sz' => 57,'lot' => 58,'lot_order' => 59,'dbpc' => 60,'chk_digit' => 61,'rec_type' => 62,'county' => 63,'geo_lat' => 64,'geo_long' => 65,'msa' => 66,'geo_blk' => 67,'geo_match' => 68,'err_stat' => 69,'append_rawaid' => 70,'best_ssn' => 71,'best_dob' => 72,'process_date' => 73,'activecode' => 74,'date_first_seen' => 75,'date_last_seen' => 76,'date_vendor_first_reported' => 77,'date_vendor_last_reported' => 78,'current_rec' => 79,0);
//Individual field level validation
EXPORT Make_clean_email(SALT30.StrType s0) := s0;
EXPORT InValid_clean_email(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_clean_email(UNSIGNED1 wh) := '';
EXPORT Make_append_email_username(SALT30.StrType s0) := s0;
EXPORT InValid_append_email_username(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_email_username(UNSIGNED1 wh) := '';
EXPORT Make_append_domain(SALT30.StrType s0) := s0;
EXPORT InValid_append_domain(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_domain(UNSIGNED1 wh) := '';
EXPORT Make_append_domain_type(SALT30.StrType s0) := s0;
EXPORT InValid_append_domain_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_domain_type(UNSIGNED1 wh) := '';
EXPORT Make_append_domain_root(SALT30.StrType s0) := s0;
EXPORT InValid_append_domain_root(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_domain_root(UNSIGNED1 wh) := '';
EXPORT Make_append_domain_ext(SALT30.StrType s0) := s0;
EXPORT InValid_append_domain_ext(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_domain_ext(UNSIGNED1 wh) := '';
EXPORT Make_append_is_tld_state(SALT30.StrType s0) := s0;
EXPORT InValid_append_is_tld_state(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_is_tld_state(UNSIGNED1 wh) := '';
EXPORT Make_append_is_tld_generic(SALT30.StrType s0) := s0;
EXPORT InValid_append_is_tld_generic(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_is_tld_generic(UNSIGNED1 wh) := '';
EXPORT Make_append_is_tld_country(SALT30.StrType s0) := s0;
EXPORT InValid_append_is_tld_country(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_is_tld_country(UNSIGNED1 wh) := '';
EXPORT Make_append_is_valid_domain_ext(SALT30.StrType s0) := s0;
EXPORT InValid_append_is_valid_domain_ext(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_is_valid_domain_ext(UNSIGNED1 wh) := '';
EXPORT Make_email_rec_key(SALT30.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_email_rec_key(SALT30.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_email_rec_key(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_email_src(SALT30.StrType s0) := MakeFT_invalid_source(s0);
EXPORT InValid_email_src(SALT30.StrType s) := InValidFT_invalid_source(s);
EXPORT InValidMessage_email_src(UNSIGNED1 wh) := InValidMessageFT_invalid_source(wh);
EXPORT Make_rec_src_all(SALT30.StrType s0) := s0;
EXPORT InValid_rec_src_all(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_rec_src_all(UNSIGNED1 wh) := '';
EXPORT Make_email_src_all(SALT30.StrType s0) := s0;
EXPORT InValid_email_src_all(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_email_src_all(UNSIGNED1 wh) := '';
EXPORT Make_email_src_num(SALT30.StrType s0) := s0;
EXPORT InValid_email_src_num(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_email_src_num(UNSIGNED1 wh) := '';
EXPORT Make_num_email_per_did(SALT30.StrType s0) := s0;
EXPORT InValid_num_email_per_did(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_num_email_per_did(UNSIGNED1 wh) := '';
EXPORT Make_num_did_per_email(SALT30.StrType s0) := s0;
EXPORT InValid_num_did_per_email(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_num_did_per_email(UNSIGNED1 wh) := '';
EXPORT Make_orig_pmghousehold_id(SALT30.StrType s0) := s0;
EXPORT InValid_orig_pmghousehold_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_pmghousehold_id(UNSIGNED1 wh) := '';
EXPORT Make_orig_pmgindividual_id(SALT30.StrType s0) := s0;
EXPORT InValid_orig_pmgindividual_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_pmgindividual_id(UNSIGNED1 wh) := '';
EXPORT Make_orig_first_name(SALT30.StrType s0) := s0;
EXPORT InValid_orig_first_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_first_name(UNSIGNED1 wh) := '';
EXPORT Make_orig_last_name(SALT30.StrType s0) := s0;
EXPORT InValid_orig_last_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_last_name(UNSIGNED1 wh) := '';
EXPORT Make_orig_address(SALT30.StrType s0) := s0;
EXPORT InValid_orig_address(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_address(UNSIGNED1 wh) := '';
EXPORT Make_orig_city(SALT30.StrType s0) := s0;
EXPORT InValid_orig_city(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := '';
EXPORT Make_orig_state(SALT30.StrType s0) := s0;
EXPORT InValid_orig_state(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := '';
EXPORT Make_orig_zip(SALT30.StrType s0) := s0;
EXPORT InValid_orig_zip(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := '';
EXPORT Make_orig_zip4(SALT30.StrType s0) := s0;
EXPORT InValid_orig_zip4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := '';
EXPORT Make_orig_email(SALT30.StrType s0) := s0;
EXPORT InValid_orig_email(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_email(UNSIGNED1 wh) := '';
EXPORT Make_orig_ip(SALT30.StrType s0) := s0;
EXPORT InValid_orig_ip(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_ip(UNSIGNED1 wh) := '';
EXPORT Make_orig_login_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_login_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_login_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_orig_site(SALT30.StrType s0) := s0;
EXPORT InValid_orig_site(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_site(UNSIGNED1 wh) := '';
EXPORT Make_orig_e360_id(SALT30.StrType s0) := s0;
EXPORT InValid_orig_e360_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_e360_id(UNSIGNED1 wh) := '';
EXPORT Make_orig_teramedia_id(SALT30.StrType s0) := s0;
EXPORT InValid_orig_teramedia_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_teramedia_id(UNSIGNED1 wh) := '';
EXPORT Make_did(SALT30.StrType s0) := s0;
EXPORT InValid_did(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
EXPORT Make_did_score(SALT30.StrType s0) := s0;
EXPORT InValid_did_score(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
EXPORT Make_did_type(SALT30.StrType s0) := s0;
EXPORT InValid_did_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_did_type(UNSIGNED1 wh) := '';
EXPORT Make_is_did_prop(SALT30.StrType s0) := s0;
EXPORT InValid_is_did_prop(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_is_did_prop(UNSIGNED1 wh) := '';
EXPORT Make_hhid(SALT30.StrType s0) := s0;
EXPORT InValid_hhid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_hhid(UNSIGNED1 wh) := '';
EXPORT Make_title(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_title(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_fname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_mname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_mname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_lname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_suffix(SALT30.StrType s0) := MakeFT_invalid_alnum(s0);
EXPORT InValid_name_suffix(SALT30.StrType s) := InValidFT_invalid_alnum(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alnum(wh);
EXPORT Make_name_score(SALT30.StrType s0) := s0;
EXPORT InValid_name_score(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
EXPORT Make_prim_range(SALT30.StrType s0) := s0;
EXPORT InValid_prim_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
EXPORT Make_predir(SALT30.StrType s0) := MakeFT_invalid_dir(s0);
EXPORT InValid_predir(SALT30.StrType s) := InValidFT_invalid_dir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_dir(wh);
EXPORT Make_prim_name(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_prim_name(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_addr_suffix(SALT30.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
EXPORT Make_postdir(SALT30.StrType s0) := MakeFT_invalid_dir(s0);
EXPORT InValid_postdir(SALT30.StrType s) := InValidFT_invalid_dir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_dir(wh);
EXPORT Make_unit_desig(SALT30.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
EXPORT Make_sec_range(SALT30.StrType s0) := s0;
EXPORT InValid_sec_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
EXPORT Make_p_city_name(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_city_name(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_v_city_name(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_v_city_name(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_st(SALT30.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_st(SALT30.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_zip(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_zip4(SALT30.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_zip4(SALT30.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_cart(SALT30.StrType s0) := s0;
EXPORT InValid_cart(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
EXPORT Make_cr_sort_sz(SALT30.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
EXPORT Make_lot(SALT30.StrType s0) := s0;
EXPORT InValid_lot(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
EXPORT Make_lot_order(SALT30.StrType s0) := s0;
EXPORT InValid_lot_order(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
EXPORT Make_dbpc(SALT30.StrType s0) := s0;
EXPORT InValid_dbpc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
EXPORT Make_chk_digit(SALT30.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
EXPORT Make_rec_type(SALT30.StrType s0) := s0;
EXPORT InValid_rec_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
EXPORT Make_county(SALT30.StrType s0) := s0;
EXPORT InValid_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
EXPORT Make_geo_lat(SALT30.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
EXPORT Make_geo_long(SALT30.StrType s0) := s0;
EXPORT InValid_geo_long(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
EXPORT Make_msa(SALT30.StrType s0) := s0;
EXPORT InValid_msa(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
EXPORT Make_geo_blk(SALT30.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
EXPORT Make_geo_match(SALT30.StrType s0) := s0;
EXPORT InValid_geo_match(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
EXPORT Make_err_stat(SALT30.StrType s0) := s0;
EXPORT InValid_err_stat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
EXPORT Make_append_rawaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_rawaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_rawaid(UNSIGNED1 wh) := '';
EXPORT Make_best_ssn(SALT30.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_best_ssn(SALT30.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_best_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
EXPORT Make_best_dob(SALT30.StrType s0) := MakeFT_invalid_dob(s0);
EXPORT InValid_best_dob(SALT30.StrType s) := InValidFT_invalid_dob(s);
EXPORT InValidMessage_best_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_dob(wh);
EXPORT Make_process_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_process_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_activecode(SALT30.StrType s0) := MakeFT_invalid_activecode(s0);
EXPORT InValid_activecode(SALT30.StrType s) := InValidFT_invalid_activecode(s);
EXPORT InValidMessage_activecode(UNSIGNED1 wh) := InValidMessageFT_invalid_activecode(wh);
EXPORT Make_date_first_seen(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_first_seen(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_last_seen(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_last_seen(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_vendor_first_reported(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_first_reported(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_vendor_last_reported(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_last_reported(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_current_rec(SALT30.StrType s0) := s0;
EXPORT InValid_current_rec(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_current_rec(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_Email_Data;
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
    BOOLEAN Diff_clean_email;
    BOOLEAN Diff_append_email_username;
    BOOLEAN Diff_append_domain;
    BOOLEAN Diff_append_domain_type;
    BOOLEAN Diff_append_domain_root;
    BOOLEAN Diff_append_domain_ext;
    BOOLEAN Diff_append_is_tld_state;
    BOOLEAN Diff_append_is_tld_generic;
    BOOLEAN Diff_append_is_tld_country;
    BOOLEAN Diff_append_is_valid_domain_ext;
    BOOLEAN Diff_email_rec_key;
    BOOLEAN Diff_email_src;
    BOOLEAN Diff_rec_src_all;
    BOOLEAN Diff_email_src_all;
    BOOLEAN Diff_email_src_num;
    BOOLEAN Diff_num_email_per_did;
    BOOLEAN Diff_num_did_per_email;
    BOOLEAN Diff_orig_pmghousehold_id;
    BOOLEAN Diff_orig_pmgindividual_id;
    BOOLEAN Diff_orig_first_name;
    BOOLEAN Diff_orig_last_name;
    BOOLEAN Diff_orig_address;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_email;
    BOOLEAN Diff_orig_ip;
    BOOLEAN Diff_orig_login_date;
    BOOLEAN Diff_orig_site;
    BOOLEAN Diff_orig_e360_id;
    BOOLEAN Diff_orig_teramedia_id;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_did_type;
    BOOLEAN Diff_is_did_prop;
    BOOLEAN Diff_hhid;
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
    BOOLEAN Diff_append_rawaid;
    BOOLEAN Diff_best_ssn;
    BOOLEAN Diff_best_dob;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_activecode;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_current_rec;
    SALT30.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_clean_email := le.clean_email <> ri.clean_email;
    SELF.Diff_append_email_username := le.append_email_username <> ri.append_email_username;
    SELF.Diff_append_domain := le.append_domain <> ri.append_domain;
    SELF.Diff_append_domain_type := le.append_domain_type <> ri.append_domain_type;
    SELF.Diff_append_domain_root := le.append_domain_root <> ri.append_domain_root;
    SELF.Diff_append_domain_ext := le.append_domain_ext <> ri.append_domain_ext;
    SELF.Diff_append_is_tld_state := le.append_is_tld_state <> ri.append_is_tld_state;
    SELF.Diff_append_is_tld_generic := le.append_is_tld_generic <> ri.append_is_tld_generic;
    SELF.Diff_append_is_tld_country := le.append_is_tld_country <> ri.append_is_tld_country;
    SELF.Diff_append_is_valid_domain_ext := le.append_is_valid_domain_ext <> ri.append_is_valid_domain_ext;
    SELF.Diff_email_rec_key := le.email_rec_key <> ri.email_rec_key;
    SELF.Diff_email_src := le.email_src <> ri.email_src;
    SELF.Diff_rec_src_all := le.rec_src_all <> ri.rec_src_all;
    SELF.Diff_email_src_all := le.email_src_all <> ri.email_src_all;
    SELF.Diff_email_src_num := le.email_src_num <> ri.email_src_num;
    SELF.Diff_num_email_per_did := le.num_email_per_did <> ri.num_email_per_did;
    SELF.Diff_num_did_per_email := le.num_did_per_email <> ri.num_did_per_email;
    SELF.Diff_orig_pmghousehold_id := le.orig_pmghousehold_id <> ri.orig_pmghousehold_id;
    SELF.Diff_orig_pmgindividual_id := le.orig_pmgindividual_id <> ri.orig_pmgindividual_id;
    SELF.Diff_orig_first_name := le.orig_first_name <> ri.orig_first_name;
    SELF.Diff_orig_last_name := le.orig_last_name <> ri.orig_last_name;
    SELF.Diff_orig_address := le.orig_address <> ri.orig_address;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_email := le.orig_email <> ri.orig_email;
    SELF.Diff_orig_ip := le.orig_ip <> ri.orig_ip;
    SELF.Diff_orig_login_date := le.orig_login_date <> ri.orig_login_date;
    SELF.Diff_orig_site := le.orig_site <> ri.orig_site;
    SELF.Diff_orig_e360_id := le.orig_e360_id <> ri.orig_e360_id;
    SELF.Diff_orig_teramedia_id := le.orig_teramedia_id <> ri.orig_teramedia_id;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_did_type := le.did_type <> ri.did_type;
    SELF.Diff_is_did_prop := le.is_did_prop <> ri.is_did_prop;
    SELF.Diff_hhid := le.hhid <> ri.hhid;
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
    SELF.Diff_append_rawaid := le.append_rawaid <> ri.append_rawaid;
    SELF.Diff_best_ssn := le.best_ssn <> ri.best_ssn;
    SELF.Diff_best_dob := le.best_dob <> ri.best_dob;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_activecode := le.activecode <> ri.activecode;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_current_rec := le.current_rec <> ri.current_rec;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.email_src;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_clean_email,1,0)+ IF( SELF.Diff_append_email_username,1,0)+ IF( SELF.Diff_append_domain,1,0)+ IF( SELF.Diff_append_domain_type,1,0)+ IF( SELF.Diff_append_domain_root,1,0)+ IF( SELF.Diff_append_domain_ext,1,0)+ IF( SELF.Diff_append_is_tld_state,1,0)+ IF( SELF.Diff_append_is_tld_generic,1,0)+ IF( SELF.Diff_append_is_tld_country,1,0)+ IF( SELF.Diff_append_is_valid_domain_ext,1,0)+ IF( SELF.Diff_email_rec_key,1,0)+ IF( SELF.Diff_email_src,1,0)+ IF( SELF.Diff_rec_src_all,1,0)+ IF( SELF.Diff_email_src_all,1,0)+ IF( SELF.Diff_email_src_num,1,0)+ IF( SELF.Diff_num_email_per_did,1,0)+ IF( SELF.Diff_num_did_per_email,1,0)+ IF( SELF.Diff_orig_pmghousehold_id,1,0)+ IF( SELF.Diff_orig_pmgindividual_id,1,0)+ IF( SELF.Diff_orig_first_name,1,0)+ IF( SELF.Diff_orig_last_name,1,0)+ IF( SELF.Diff_orig_address,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_email,1,0)+ IF( SELF.Diff_orig_ip,1,0)+ IF( SELF.Diff_orig_login_date,1,0)+ IF( SELF.Diff_orig_site,1,0)+ IF( SELF.Diff_orig_e360_id,1,0)+ IF( SELF.Diff_orig_teramedia_id,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_did_type,1,0)+ IF( SELF.Diff_is_did_prop,1,0)+ IF( SELF.Diff_hhid,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_append_rawaid,1,0)+ IF( SELF.Diff_best_ssn,1,0)+ IF( SELF.Diff_best_dob,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_activecode,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_current_rec,1,0);
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
    Count_Diff_clean_email := COUNT(GROUP,%Closest%.Diff_clean_email);
    Count_Diff_append_email_username := COUNT(GROUP,%Closest%.Diff_append_email_username);
    Count_Diff_append_domain := COUNT(GROUP,%Closest%.Diff_append_domain);
    Count_Diff_append_domain_type := COUNT(GROUP,%Closest%.Diff_append_domain_type);
    Count_Diff_append_domain_root := COUNT(GROUP,%Closest%.Diff_append_domain_root);
    Count_Diff_append_domain_ext := COUNT(GROUP,%Closest%.Diff_append_domain_ext);
    Count_Diff_append_is_tld_state := COUNT(GROUP,%Closest%.Diff_append_is_tld_state);
    Count_Diff_append_is_tld_generic := COUNT(GROUP,%Closest%.Diff_append_is_tld_generic);
    Count_Diff_append_is_tld_country := COUNT(GROUP,%Closest%.Diff_append_is_tld_country);
    Count_Diff_append_is_valid_domain_ext := COUNT(GROUP,%Closest%.Diff_append_is_valid_domain_ext);
    Count_Diff_email_rec_key := COUNT(GROUP,%Closest%.Diff_email_rec_key);
    Count_Diff_email_src := COUNT(GROUP,%Closest%.Diff_email_src);
    Count_Diff_rec_src_all := COUNT(GROUP,%Closest%.Diff_rec_src_all);
    Count_Diff_email_src_all := COUNT(GROUP,%Closest%.Diff_email_src_all);
    Count_Diff_email_src_num := COUNT(GROUP,%Closest%.Diff_email_src_num);
    Count_Diff_num_email_per_did := COUNT(GROUP,%Closest%.Diff_num_email_per_did);
    Count_Diff_num_did_per_email := COUNT(GROUP,%Closest%.Diff_num_did_per_email);
    Count_Diff_orig_pmghousehold_id := COUNT(GROUP,%Closest%.Diff_orig_pmghousehold_id);
    Count_Diff_orig_pmgindividual_id := COUNT(GROUP,%Closest%.Diff_orig_pmgindividual_id);
    Count_Diff_orig_first_name := COUNT(GROUP,%Closest%.Diff_orig_first_name);
    Count_Diff_orig_last_name := COUNT(GROUP,%Closest%.Diff_orig_last_name);
    Count_Diff_orig_address := COUNT(GROUP,%Closest%.Diff_orig_address);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_email := COUNT(GROUP,%Closest%.Diff_orig_email);
    Count_Diff_orig_ip := COUNT(GROUP,%Closest%.Diff_orig_ip);
    Count_Diff_orig_login_date := COUNT(GROUP,%Closest%.Diff_orig_login_date);
    Count_Diff_orig_site := COUNT(GROUP,%Closest%.Diff_orig_site);
    Count_Diff_orig_e360_id := COUNT(GROUP,%Closest%.Diff_orig_e360_id);
    Count_Diff_orig_teramedia_id := COUNT(GROUP,%Closest%.Diff_orig_teramedia_id);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_did_type := COUNT(GROUP,%Closest%.Diff_did_type);
    Count_Diff_is_did_prop := COUNT(GROUP,%Closest%.Diff_is_did_prop);
    Count_Diff_hhid := COUNT(GROUP,%Closest%.Diff_hhid);
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
    Count_Diff_append_rawaid := COUNT(GROUP,%Closest%.Diff_append_rawaid);
    Count_Diff_best_ssn := COUNT(GROUP,%Closest%.Diff_best_ssn);
    Count_Diff_best_dob := COUNT(GROUP,%Closest%.Diff_best_dob);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_activecode := COUNT(GROUP,%Closest%.Diff_activecode);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_current_rec := COUNT(GROUP,%Closest%.Diff_current_rec);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
