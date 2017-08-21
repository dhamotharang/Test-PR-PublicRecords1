IMPORT ut,SALT31;
EXPORT base_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','bdid','bdid_score','best_dob','best_ssn','data_state','name','address','citystate','zipcode','phone','providertypedesc','medicaidid','npi','entity_type_code','companyname','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'did' => 1,'did_score' => 2,'bdid' => 3,'bdid_score' => 4,'best_dob' => 5,'best_ssn' => 6,'data_state' => 7,'name' => 8,'address' => 9,'citystate' => 10,'zipcode' => 11,'phone' => 12,'providertypedesc' => 13,'medicaidid' => 14,'npi' => 15,'entity_type_code' => 16,'companyname' => 17,'src' => 18,'dt_vendor_first_reported' => 19,'dt_vendor_last_reported' => 20,'dt_first_seen' => 21,'dt_last_seen' => 22,'record_type' => 23,'source_rid' => 24,'lnpid' => 25,'title' => 26,'fname' => 27,'mname' => 28,'lname' => 29,'name_suffix' => 30,'name_type' => 31,'nid' => 32,'clean_clinic_name' => 33,'prepped_addr1' => 34,'prepped_addr2' => 35,'prim_range' => 36,'predir' => 37,'prim_name' => 38,'addr_suffix' => 39,'postdir' => 40,'unit_desig' => 41,'sec_range' => 42,'p_city_name' => 43,'v_city_name' => 44,'st' => 45,'zip' => 46,'zip4' => 47,'cart' => 48,'cr_sort_sz' => 49,'lot' => 50,'lot_order' => 51,'dbpc' => 52,'chk_digit' => 53,'rec_type' => 54,'fips_st' => 55,'fips_county' => 56,'geo_lat' => 57,'geo_long' => 58,'msa' => 59,'geo_blk' => 60,'geo_match' => 61,'err_stat' => 62,'rawaid' => 63,'aceaid' => 64,'clean_phone' => 65,'dotid' => 66,'dotscore' => 67,'dotweight' => 68,'empid' => 69,'empscore' => 70,'empweight' => 71,'powid' => 72,'powscore' => 73,'powweight' => 74,'proxid' => 75,'proxscore' => 76,'proxweight' => 77,'seleid' => 78,'selescore' => 79,'seleweight' => 80,'orgid' => 81,'orgscore' => 82,'orgweight' => 83,'ultid' => 84,'ultscore' => 85,'ultweight' => 86,0);
EXPORT MakeFT_did(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,12,10,11,9,8,7'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_did_score(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'013456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did_score(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'013456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did_score(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('013456789 '),SALT31.HygieneErrors.NotLength('1,3,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_bdid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_bdid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bdid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,10,9,8,7'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_bdid_score(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'01 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_bdid_score(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'01 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bdid_score(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('01 '),SALT31.HygieneErrors.NotLength('1,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_best_dob(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_best_dob(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 8),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_best_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,8'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_best_ssn(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_best_ssn(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_best_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,9'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_data_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'IL '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_data_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'IL '))),~(LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_data_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('IL '),SALT31.HygieneErrors.NotLength('2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' 012345678ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' 012345678ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' 012345678ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_address(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #,0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_address(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #,0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_address(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #,0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_citystate(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_citystate(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,ABCDEFGHIJKLMNOPQRSTUVWXY '))));
EXPORT InValidMessageFT_citystate(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_zipcode(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zipcode(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phone(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()-0123456789e '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()-0123456789e '))),~(LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 11),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()-0123456789e '),SALT31.HygieneErrors.NotLength('14,11'),SALT31.HygieneErrors.NotWords('2'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_providertypedesc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-ABCDEFGHIKLMNOPRSTUVWY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_providertypedesc(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-ABCDEFGHIKLMNOPRSTUVWY '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 2 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 3 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 4 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 5));
EXPORT InValidMessageFT_providertypedesc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('-ABCDEFGHIKLMNOPRSTUVWY '),SALT31.HygieneErrors.NotWords('1,2,3,4,5'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_medicaidid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_medicaidid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_medicaidid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('9,12,10'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_npi(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_npi(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_npi(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('10'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_entity_type_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'12 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_entity_type_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'12 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_entity_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('12 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_companyname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' 012345678ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_companyname(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' 012345678ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_companyname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars(' 012345678ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_src(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'DHILMOST_ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_src(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'DHILMOST_ '))),~(LENGTH(TRIM(s)) = 11),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_src(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('DHILMOST_ '),SALT31.HygieneErrors.NotLength('11'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_vendor_first_reported(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0125 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_first_reported(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0125 '))),~(LENGTH(TRIM(s)) = 8),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0125 '),SALT31.HygieneErrors.NotLength('8'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_vendor_last_reported(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0125 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_last_reported(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0125 '))),~(LENGTH(TRIM(s)) = 8),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_vendor_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0125 '),SALT31.HygieneErrors.NotLength('8'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_first_seen(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_first_seen(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_last_seen(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_last_seen(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_record_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'C '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_record_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'C '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('C '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_source_rid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_source_rid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 17),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_source_rid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('19,20,18,17'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lnpid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lnpid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lnpid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('7,10,8,1,6,9,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_title(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'MRS '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_title(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'MRS '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_title(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('MRS '),SALT31.HygieneErrors.NotLength('2,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_name_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_suffix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_name_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'BIP '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'BIP '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('BIP '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_nid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_nid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 17),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_nid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('19,20,18,17'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_clinic_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_clinic_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_clinic_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prepped_addr1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #,0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_addr1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #,0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_prepped_addr1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #,0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prepped_addr2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,0123456789ABCDEFGHIJKLMNOPQRSTUVWY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_addr2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,0123456789ABCDEFGHIJKLMNOPQRSTUVWY '))));
EXPORT InValidMessageFT_prepped_addr2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,0123456789ABCDEFGHIJKLMNOPQRSTUVWY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prim_range(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789BNW '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_range(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789BNW '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789BNW '),SALT31.HygieneErrors.NotLength('4,3,5,2,1,0,6'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_predir(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_predir(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ENSW '),SALT31.HygieneErrors.NotLength('1,0,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prim_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_addr_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEHIKLNPRSTVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addr_suffix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEHIKLNPRSTVWYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEHIKLNPRSTVWYZ '),SALT31.HygieneErrors.NotLength('2,3,4,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_postdir(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_postdir(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ENSW '),SALT31.HygieneErrors.NotLength('0,1,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_unit_desig(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'#ABDEFGILMNOPRSTUX '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_unit_desig(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'#ABDEFGILMNOPRSTUX '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('#ABDEFGILMNOPRSTUX '),SALT31.HygieneErrors.NotLength('0,3,1,4,2,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sec_range(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789ABCDEFGHIJKLMNOPRSTVW '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sec_range(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789ABCDEFGHIJKLMNOPRSTVW '))));
EXPORT InValidMessageFT_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789ABCDEFGHIJKLMNOPRSTVW '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_p_city_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_p_city_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWYZ '))));
EXPORT InValidMessageFT_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_v_city_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_v_city_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWYZ '))));
EXPORT InValidMessageFT_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_st(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ACDEFGHIKLMNOPRSTVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_st(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ACDEFGHIKLMNOPRSTVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_st(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ACDEFGHIKLMNOPRSTVWXYZ '),SALT31.HygieneErrors.NotLength('2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_zip4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('4,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cart(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789BCR '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cart(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789BCR '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789BCR '),SALT31.HygieneErrors.NotLength('4,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cr_sort_sz(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'BCD '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cr_sort_sz(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'BCD '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('BCD '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lot(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('4,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lot_order(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'AD '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot_order(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'AD '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('AD '),SALT31.HygieneErrors.NotLength('1,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dbpc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dbpc(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('2,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_chk_digit(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_chk_digit(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_rec_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'DFHPSU '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rec_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'DFHPSU '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('DFHPSU '),SALT31.HygieneErrors.NotLength('1,2,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fips_st(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fips_st(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_fips_st(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fips_county(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fips_county(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_geo_lat(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'.0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_lat(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'.0123456789 '))),~(LENGTH(TRIM(s)) = 9),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_lat(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('.0123456789 '),SALT31.HygieneErrors.NotLength('9'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_geo_long(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_long(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_long(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789 '),SALT31.HygieneErrors.NotLength('10,11'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_msa(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_msa(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_geo_blk(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_blk(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 7),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('7'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_geo_match(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0145 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_geo_match(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0145 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0145 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_err_stat(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCES '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_err_stat(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCES '))),~(LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCES '),SALT31.HygieneErrors.NotLength('4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_rawaid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rawaid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 11),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_rawaid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('12,11'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_aceaid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_aceaid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 12),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_aceaid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('12'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_phone(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_phone(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('10,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dotid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dotid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dotid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dotscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dotscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dotscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dotweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dotweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dotweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_empid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_empid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_empid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_empscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_empscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_empscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_empweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_empweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_empweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_powid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_powid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_powid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,11,9,8,10,7,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_powscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0145789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_powscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0145789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_powscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0145789 '),SALT31.HygieneErrors.NotLength('1,3,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_powweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_powweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_powweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,2,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_proxid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_proxid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_proxid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,11,9,8,10,7,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_proxscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'014789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_proxscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'014789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_proxscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('014789 '),SALT31.HygieneErrors.NotLength('1,3,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_proxweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_proxweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_proxweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,2,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_seleid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_seleid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_seleid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,11,8,9,10,7,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_selescore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'014789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_selescore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'014789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_selescore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('014789 '),SALT31.HygieneErrors.NotLength('1,3,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_seleweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_seleweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_seleweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,2,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_orgid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orgid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orgid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,11,8,9,10,7,5,6'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_orgscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'014789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orgscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'014789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orgscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('014789 '),SALT31.HygieneErrors.NotLength('1,3,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_orgweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orgweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_orgweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,2,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ultid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ultid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ultid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,11,8,9,10,7,5,6'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ultscore(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'014789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ultscore(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'014789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ultscore(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('014789 '),SALT31.HygieneErrors.NotLength('1,3,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ultweight(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ultweight(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ultweight(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,2,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','bdid','bdid_score','best_dob','best_ssn','data_state','name','address','citystate','zipcode','phone','providertypedesc','medicaidid','npi','entity_type_code','companyname','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'did' => 1,'did_score' => 2,'bdid' => 3,'bdid_score' => 4,'best_dob' => 5,'best_ssn' => 6,'data_state' => 7,'name' => 8,'address' => 9,'citystate' => 10,'zipcode' => 11,'phone' => 12,'providertypedesc' => 13,'medicaidid' => 14,'npi' => 15,'entity_type_code' => 16,'companyname' => 17,'src' => 18,'dt_vendor_first_reported' => 19,'dt_vendor_last_reported' => 20,'dt_first_seen' => 21,'dt_last_seen' => 22,'record_type' => 23,'source_rid' => 24,'lnpid' => 25,'title' => 26,'fname' => 27,'mname' => 28,'lname' => 29,'name_suffix' => 30,'name_type' => 31,'nid' => 32,'clean_clinic_name' => 33,'prepped_addr1' => 34,'prepped_addr2' => 35,'prim_range' => 36,'predir' => 37,'prim_name' => 38,'addr_suffix' => 39,'postdir' => 40,'unit_desig' => 41,'sec_range' => 42,'p_city_name' => 43,'v_city_name' => 44,'st' => 45,'zip' => 46,'zip4' => 47,'cart' => 48,'cr_sort_sz' => 49,'lot' => 50,'lot_order' => 51,'dbpc' => 52,'chk_digit' => 53,'rec_type' => 54,'fips_st' => 55,'fips_county' => 56,'geo_lat' => 57,'geo_long' => 58,'msa' => 59,'geo_blk' => 60,'geo_match' => 61,'err_stat' => 62,'rawaid' => 63,'aceaid' => 64,'clean_phone' => 65,'dotid' => 66,'dotscore' => 67,'dotweight' => 68,'empid' => 69,'empscore' => 70,'empweight' => 71,'powid' => 72,'powscore' => 73,'powweight' => 74,'proxid' => 75,'proxscore' => 76,'proxweight' => 77,'seleid' => 78,'selescore' => 79,'seleweight' => 80,'orgid' => 81,'orgscore' => 82,'orgweight' => 83,'ultid' => 84,'ultscore' => 85,'ultweight' => 86,0);
//Individual field level validation
EXPORT Make_did(SALT31.StrType s0) := MakeFT_did(s0);
EXPORT InValid_did(SALT31.StrType s) := InValidFT_did(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_did(wh);
EXPORT Make_did_score(SALT31.StrType s0) := MakeFT_did_score(s0);
EXPORT InValid_did_score(SALT31.StrType s) := InValidFT_did_score(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_did_score(wh);
EXPORT Make_bdid(SALT31.StrType s0) := MakeFT_bdid(s0);
EXPORT InValid_bdid(SALT31.StrType s) := InValidFT_bdid(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_bdid(wh);
EXPORT Make_bdid_score(SALT31.StrType s0) := MakeFT_bdid_score(s0);
EXPORT InValid_bdid_score(SALT31.StrType s) := InValidFT_bdid_score(s);
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := InValidMessageFT_bdid_score(wh);
EXPORT Make_best_dob(SALT31.StrType s0) := MakeFT_best_dob(s0);
EXPORT InValid_best_dob(SALT31.StrType s) := InValidFT_best_dob(s);
EXPORT InValidMessage_best_dob(UNSIGNED1 wh) := InValidMessageFT_best_dob(wh);
EXPORT Make_best_ssn(SALT31.StrType s0) := MakeFT_best_ssn(s0);
EXPORT InValid_best_ssn(SALT31.StrType s) := InValidFT_best_ssn(s);
EXPORT InValidMessage_best_ssn(UNSIGNED1 wh) := InValidMessageFT_best_ssn(wh);
EXPORT Make_data_state(SALT31.StrType s0) := MakeFT_data_state(s0);
EXPORT InValid_data_state(SALT31.StrType s) := InValidFT_data_state(s);
EXPORT InValidMessage_data_state(UNSIGNED1 wh) := InValidMessageFT_data_state(wh);
EXPORT Make_name(SALT31.StrType s0) := MakeFT_name(s0);
EXPORT InValid_name(SALT31.StrType s) := InValidFT_name(s);
EXPORT InValidMessage_name(UNSIGNED1 wh) := InValidMessageFT_name(wh);
EXPORT Make_address(SALT31.StrType s0) := MakeFT_address(s0);
EXPORT InValid_address(SALT31.StrType s) := InValidFT_address(s);
EXPORT InValidMessage_address(UNSIGNED1 wh) := InValidMessageFT_address(wh);
EXPORT Make_citystate(SALT31.StrType s0) := MakeFT_citystate(s0);
EXPORT InValid_citystate(SALT31.StrType s) := InValidFT_citystate(s);
EXPORT InValidMessage_citystate(UNSIGNED1 wh) := InValidMessageFT_citystate(wh);
EXPORT Make_zipcode(SALT31.StrType s0) := MakeFT_zipcode(s0);
EXPORT InValid_zipcode(SALT31.StrType s) := InValidFT_zipcode(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_zipcode(wh);
EXPORT Make_phone(SALT31.StrType s0) := MakeFT_phone(s0);
EXPORT InValid_phone(SALT31.StrType s) := InValidFT_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_phone(wh);
EXPORT Make_providertypedesc(SALT31.StrType s0) := MakeFT_providertypedesc(s0);
EXPORT InValid_providertypedesc(SALT31.StrType s) := InValidFT_providertypedesc(s);
EXPORT InValidMessage_providertypedesc(UNSIGNED1 wh) := InValidMessageFT_providertypedesc(wh);
EXPORT Make_medicaidid(SALT31.StrType s0) := MakeFT_medicaidid(s0);
EXPORT InValid_medicaidid(SALT31.StrType s) := InValidFT_medicaidid(s);
EXPORT InValidMessage_medicaidid(UNSIGNED1 wh) := InValidMessageFT_medicaidid(wh);
EXPORT Make_npi(SALT31.StrType s0) := MakeFT_npi(s0);
EXPORT InValid_npi(SALT31.StrType s) := InValidFT_npi(s);
EXPORT InValidMessage_npi(UNSIGNED1 wh) := InValidMessageFT_npi(wh);
EXPORT Make_entity_type_code(SALT31.StrType s0) := MakeFT_entity_type_code(s0);
EXPORT InValid_entity_type_code(SALT31.StrType s) := InValidFT_entity_type_code(s);
EXPORT InValidMessage_entity_type_code(UNSIGNED1 wh) := InValidMessageFT_entity_type_code(wh);
EXPORT Make_companyname(SALT31.StrType s0) := MakeFT_companyname(s0);
EXPORT InValid_companyname(SALT31.StrType s) := InValidFT_companyname(s);
EXPORT InValidMessage_companyname(UNSIGNED1 wh) := InValidMessageFT_companyname(wh);
EXPORT Make_src(SALT31.StrType s0) := MakeFT_src(s0);
EXPORT InValid_src(SALT31.StrType s) := InValidFT_src(s);
EXPORT InValidMessage_src(UNSIGNED1 wh) := InValidMessageFT_src(wh);
EXPORT Make_dt_vendor_first_reported(SALT31.StrType s0) := MakeFT_dt_vendor_first_reported(s0);
EXPORT InValid_dt_vendor_first_reported(SALT31.StrType s) := InValidFT_dt_vendor_first_reported(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_first_reported(wh);
EXPORT Make_dt_vendor_last_reported(SALT31.StrType s0) := MakeFT_dt_vendor_last_reported(s0);
EXPORT InValid_dt_vendor_last_reported(SALT31.StrType s) := InValidFT_dt_vendor_last_reported(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_last_reported(wh);
EXPORT Make_dt_first_seen(SALT31.StrType s0) := MakeFT_dt_first_seen(s0);
EXPORT InValid_dt_first_seen(SALT31.StrType s) := InValidFT_dt_first_seen(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_dt_first_seen(wh);
EXPORT Make_dt_last_seen(SALT31.StrType s0) := MakeFT_dt_last_seen(s0);
EXPORT InValid_dt_last_seen(SALT31.StrType s) := InValidFT_dt_last_seen(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_dt_last_seen(wh);
EXPORT Make_record_type(SALT31.StrType s0) := MakeFT_record_type(s0);
EXPORT InValid_record_type(SALT31.StrType s) := InValidFT_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_record_type(wh);
EXPORT Make_source_rid(SALT31.StrType s0) := MakeFT_source_rid(s0);
EXPORT InValid_source_rid(SALT31.StrType s) := InValidFT_source_rid(s);
EXPORT InValidMessage_source_rid(UNSIGNED1 wh) := InValidMessageFT_source_rid(wh);
EXPORT Make_lnpid(SALT31.StrType s0) := MakeFT_lnpid(s0);
EXPORT InValid_lnpid(SALT31.StrType s) := InValidFT_lnpid(s);
EXPORT InValidMessage_lnpid(UNSIGNED1 wh) := InValidMessageFT_lnpid(wh);
EXPORT Make_title(SALT31.StrType s0) := MakeFT_title(s0);
EXPORT InValid_title(SALT31.StrType s) := InValidFT_title(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_title(wh);
EXPORT Make_fname(SALT31.StrType s0) := MakeFT_fname(s0);
EXPORT InValid_fname(SALT31.StrType s) := InValidFT_fname(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_fname(wh);
EXPORT Make_mname(SALT31.StrType s0) := MakeFT_mname(s0);
EXPORT InValid_mname(SALT31.StrType s) := InValidFT_mname(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_mname(wh);
EXPORT Make_lname(SALT31.StrType s0) := MakeFT_lname(s0);
EXPORT InValid_lname(SALT31.StrType s) := InValidFT_lname(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_lname(wh);
EXPORT Make_name_suffix(SALT31.StrType s0) := MakeFT_name_suffix(s0);
EXPORT InValid_name_suffix(SALT31.StrType s) := InValidFT_name_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_name_suffix(wh);
EXPORT Make_name_type(SALT31.StrType s0) := MakeFT_name_type(s0);
EXPORT InValid_name_type(SALT31.StrType s) := InValidFT_name_type(s);
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := InValidMessageFT_name_type(wh);
EXPORT Make_nid(SALT31.StrType s0) := MakeFT_nid(s0);
EXPORT InValid_nid(SALT31.StrType s) := InValidFT_nid(s);
EXPORT InValidMessage_nid(UNSIGNED1 wh) := InValidMessageFT_nid(wh);
EXPORT Make_clean_clinic_name(SALT31.StrType s0) := MakeFT_clean_clinic_name(s0);
EXPORT InValid_clean_clinic_name(SALT31.StrType s) := InValidFT_clean_clinic_name(s);
EXPORT InValidMessage_clean_clinic_name(UNSIGNED1 wh) := InValidMessageFT_clean_clinic_name(wh);
EXPORT Make_prepped_addr1(SALT31.StrType s0) := MakeFT_prepped_addr1(s0);
EXPORT InValid_prepped_addr1(SALT31.StrType s) := InValidFT_prepped_addr1(s);
EXPORT InValidMessage_prepped_addr1(UNSIGNED1 wh) := InValidMessageFT_prepped_addr1(wh);
EXPORT Make_prepped_addr2(SALT31.StrType s0) := MakeFT_prepped_addr2(s0);
EXPORT InValid_prepped_addr2(SALT31.StrType s) := InValidFT_prepped_addr2(s);
EXPORT InValidMessage_prepped_addr2(UNSIGNED1 wh) := InValidMessageFT_prepped_addr2(wh);
EXPORT Make_prim_range(SALT31.StrType s0) := MakeFT_prim_range(s0);
EXPORT InValid_prim_range(SALT31.StrType s) := InValidFT_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_prim_range(wh);
EXPORT Make_predir(SALT31.StrType s0) := MakeFT_predir(s0);
EXPORT InValid_predir(SALT31.StrType s) := InValidFT_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_predir(wh);
EXPORT Make_prim_name(SALT31.StrType s0) := MakeFT_prim_name(s0);
EXPORT InValid_prim_name(SALT31.StrType s) := InValidFT_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_prim_name(wh);
EXPORT Make_addr_suffix(SALT31.StrType s0) := MakeFT_addr_suffix(s0);
EXPORT InValid_addr_suffix(SALT31.StrType s) := InValidFT_addr_suffix(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_addr_suffix(wh);
EXPORT Make_postdir(SALT31.StrType s0) := MakeFT_postdir(s0);
EXPORT InValid_postdir(SALT31.StrType s) := InValidFT_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_postdir(wh);
EXPORT Make_unit_desig(SALT31.StrType s0) := MakeFT_unit_desig(s0);
EXPORT InValid_unit_desig(SALT31.StrType s) := InValidFT_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_unit_desig(wh);
EXPORT Make_sec_range(SALT31.StrType s0) := MakeFT_sec_range(s0);
EXPORT InValid_sec_range(SALT31.StrType s) := InValidFT_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_sec_range(wh);
EXPORT Make_p_city_name(SALT31.StrType s0) := MakeFT_p_city_name(s0);
EXPORT InValid_p_city_name(SALT31.StrType s) := InValidFT_p_city_name(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_p_city_name(wh);
EXPORT Make_v_city_name(SALT31.StrType s0) := MakeFT_v_city_name(s0);
EXPORT InValid_v_city_name(SALT31.StrType s) := InValidFT_v_city_name(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_v_city_name(wh);
EXPORT Make_st(SALT31.StrType s0) := MakeFT_st(s0);
EXPORT InValid_st(SALT31.StrType s) := InValidFT_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_st(wh);
EXPORT Make_zip(SALT31.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT31.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);
EXPORT Make_zip4(SALT31.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT31.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);
EXPORT Make_cart(SALT31.StrType s0) := MakeFT_cart(s0);
EXPORT InValid_cart(SALT31.StrType s) := InValidFT_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_cart(wh);
EXPORT Make_cr_sort_sz(SALT31.StrType s0) := MakeFT_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT31.StrType s) := InValidFT_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_cr_sort_sz(wh);
EXPORT Make_lot(SALT31.StrType s0) := MakeFT_lot(s0);
EXPORT InValid_lot(SALT31.StrType s) := InValidFT_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_lot(wh);
EXPORT Make_lot_order(SALT31.StrType s0) := MakeFT_lot_order(s0);
EXPORT InValid_lot_order(SALT31.StrType s) := InValidFT_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_lot_order(wh);
EXPORT Make_dbpc(SALT31.StrType s0) := MakeFT_dbpc(s0);
EXPORT InValid_dbpc(SALT31.StrType s) := InValidFT_dbpc(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_dbpc(wh);
EXPORT Make_chk_digit(SALT31.StrType s0) := MakeFT_chk_digit(s0);
EXPORT InValid_chk_digit(SALT31.StrType s) := InValidFT_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_chk_digit(wh);
EXPORT Make_rec_type(SALT31.StrType s0) := MakeFT_rec_type(s0);
EXPORT InValid_rec_type(SALT31.StrType s) := InValidFT_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_rec_type(wh);
EXPORT Make_fips_st(SALT31.StrType s0) := MakeFT_fips_st(s0);
EXPORT InValid_fips_st(SALT31.StrType s) := InValidFT_fips_st(s);
EXPORT InValidMessage_fips_st(UNSIGNED1 wh) := InValidMessageFT_fips_st(wh);
EXPORT Make_fips_county(SALT31.StrType s0) := MakeFT_fips_county(s0);
EXPORT InValid_fips_county(SALT31.StrType s) := InValidFT_fips_county(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_fips_county(wh);
EXPORT Make_geo_lat(SALT31.StrType s0) := MakeFT_geo_lat(s0);
EXPORT InValid_geo_lat(SALT31.StrType s) := InValidFT_geo_lat(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_geo_lat(wh);
EXPORT Make_geo_long(SALT31.StrType s0) := MakeFT_geo_long(s0);
EXPORT InValid_geo_long(SALT31.StrType s) := InValidFT_geo_long(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_geo_long(wh);
EXPORT Make_msa(SALT31.StrType s0) := MakeFT_msa(s0);
EXPORT InValid_msa(SALT31.StrType s) := InValidFT_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_msa(wh);
EXPORT Make_geo_blk(SALT31.StrType s0) := MakeFT_geo_blk(s0);
EXPORT InValid_geo_blk(SALT31.StrType s) := InValidFT_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_geo_blk(wh);
EXPORT Make_geo_match(SALT31.StrType s0) := MakeFT_geo_match(s0);
EXPORT InValid_geo_match(SALT31.StrType s) := InValidFT_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_geo_match(wh);
EXPORT Make_err_stat(SALT31.StrType s0) := MakeFT_err_stat(s0);
EXPORT InValid_err_stat(SALT31.StrType s) := InValidFT_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_err_stat(wh);
EXPORT Make_rawaid(SALT31.StrType s0) := MakeFT_rawaid(s0);
EXPORT InValid_rawaid(SALT31.StrType s) := InValidFT_rawaid(s);
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := InValidMessageFT_rawaid(wh);
EXPORT Make_aceaid(SALT31.StrType s0) := MakeFT_aceaid(s0);
EXPORT InValid_aceaid(SALT31.StrType s) := InValidFT_aceaid(s);
EXPORT InValidMessage_aceaid(UNSIGNED1 wh) := InValidMessageFT_aceaid(wh);
EXPORT Make_clean_phone(SALT31.StrType s0) := MakeFT_clean_phone(s0);
EXPORT InValid_clean_phone(SALT31.StrType s) := InValidFT_clean_phone(s);
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := InValidMessageFT_clean_phone(wh);
EXPORT Make_dotid(SALT31.StrType s0) := MakeFT_dotid(s0);
EXPORT InValid_dotid(SALT31.StrType s) := InValidFT_dotid(s);
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := InValidMessageFT_dotid(wh);
EXPORT Make_dotscore(SALT31.StrType s0) := MakeFT_dotscore(s0);
EXPORT InValid_dotscore(SALT31.StrType s) := InValidFT_dotscore(s);
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := InValidMessageFT_dotscore(wh);
EXPORT Make_dotweight(SALT31.StrType s0) := MakeFT_dotweight(s0);
EXPORT InValid_dotweight(SALT31.StrType s) := InValidFT_dotweight(s);
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := InValidMessageFT_dotweight(wh);
EXPORT Make_empid(SALT31.StrType s0) := MakeFT_empid(s0);
EXPORT InValid_empid(SALT31.StrType s) := InValidFT_empid(s);
EXPORT InValidMessage_empid(UNSIGNED1 wh) := InValidMessageFT_empid(wh);
EXPORT Make_empscore(SALT31.StrType s0) := MakeFT_empscore(s0);
EXPORT InValid_empscore(SALT31.StrType s) := InValidFT_empscore(s);
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := InValidMessageFT_empscore(wh);
EXPORT Make_empweight(SALT31.StrType s0) := MakeFT_empweight(s0);
EXPORT InValid_empweight(SALT31.StrType s) := InValidFT_empweight(s);
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := InValidMessageFT_empweight(wh);
EXPORT Make_powid(SALT31.StrType s0) := MakeFT_powid(s0);
EXPORT InValid_powid(SALT31.StrType s) := InValidFT_powid(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_powid(wh);
EXPORT Make_powscore(SALT31.StrType s0) := MakeFT_powscore(s0);
EXPORT InValid_powscore(SALT31.StrType s) := InValidFT_powscore(s);
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := InValidMessageFT_powscore(wh);
EXPORT Make_powweight(SALT31.StrType s0) := MakeFT_powweight(s0);
EXPORT InValid_powweight(SALT31.StrType s) := InValidFT_powweight(s);
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := InValidMessageFT_powweight(wh);
EXPORT Make_proxid(SALT31.StrType s0) := MakeFT_proxid(s0);
EXPORT InValid_proxid(SALT31.StrType s) := InValidFT_proxid(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_proxid(wh);
EXPORT Make_proxscore(SALT31.StrType s0) := MakeFT_proxscore(s0);
EXPORT InValid_proxscore(SALT31.StrType s) := InValidFT_proxscore(s);
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := InValidMessageFT_proxscore(wh);
EXPORT Make_proxweight(SALT31.StrType s0) := MakeFT_proxweight(s0);
EXPORT InValid_proxweight(SALT31.StrType s) := InValidFT_proxweight(s);
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := InValidMessageFT_proxweight(wh);
EXPORT Make_seleid(SALT31.StrType s0) := MakeFT_seleid(s0);
EXPORT InValid_seleid(SALT31.StrType s) := InValidFT_seleid(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_seleid(wh);
EXPORT Make_selescore(SALT31.StrType s0) := MakeFT_selescore(s0);
EXPORT InValid_selescore(SALT31.StrType s) := InValidFT_selescore(s);
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := InValidMessageFT_selescore(wh);
EXPORT Make_seleweight(SALT31.StrType s0) := MakeFT_seleweight(s0);
EXPORT InValid_seleweight(SALT31.StrType s) := InValidFT_seleweight(s);
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := InValidMessageFT_seleweight(wh);
EXPORT Make_orgid(SALT31.StrType s0) := MakeFT_orgid(s0);
EXPORT InValid_orgid(SALT31.StrType s) := InValidFT_orgid(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_orgid(wh);
EXPORT Make_orgscore(SALT31.StrType s0) := MakeFT_orgscore(s0);
EXPORT InValid_orgscore(SALT31.StrType s) := InValidFT_orgscore(s);
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := InValidMessageFT_orgscore(wh);
EXPORT Make_orgweight(SALT31.StrType s0) := MakeFT_orgweight(s0);
EXPORT InValid_orgweight(SALT31.StrType s) := InValidFT_orgweight(s);
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := InValidMessageFT_orgweight(wh);
EXPORT Make_ultid(SALT31.StrType s0) := MakeFT_ultid(s0);
EXPORT InValid_ultid(SALT31.StrType s) := InValidFT_ultid(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_ultid(wh);
EXPORT Make_ultscore(SALT31.StrType s0) := MakeFT_ultscore(s0);
EXPORT InValid_ultscore(SALT31.StrType s) := InValidFT_ultscore(s);
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := InValidMessageFT_ultscore(wh);
EXPORT Make_ultweight(SALT31.StrType s0) := MakeFT_ultweight(s0);
EXPORT InValid_ultweight(SALT31.StrType s) := InValidFT_ultweight(s);
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := InValidMessageFT_ultweight(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_Medicaid_IL;
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
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_best_dob;
    BOOLEAN Diff_best_ssn;
    BOOLEAN Diff_data_state;
    BOOLEAN Diff_name;
    BOOLEAN Diff_address;
    BOOLEAN Diff_citystate;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_providertypedesc;
    BOOLEAN Diff_medicaidid;
    BOOLEAN Diff_npi;
    BOOLEAN Diff_entity_type_code;
    BOOLEAN Diff_companyname;
    BOOLEAN Diff_src;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_source_rid;
    BOOLEAN Diff_lnpid;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_nid;
    BOOLEAN Diff_clean_clinic_name;
    BOOLEAN Diff_prepped_addr1;
    BOOLEAN Diff_prepped_addr2;
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
    BOOLEAN Diff_fips_st;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_aceaid;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_best_dob := le.best_dob <> ri.best_dob;
    SELF.Diff_best_ssn := le.best_ssn <> ri.best_ssn;
    SELF.Diff_data_state := le.data_state <> ri.data_state;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_citystate := le.citystate <> ri.citystate;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_providertypedesc := le.providertypedesc <> ri.providertypedesc;
    SELF.Diff_medicaidid := le.medicaidid <> ri.medicaidid;
    SELF.Diff_npi := le.npi <> ri.npi;
    SELF.Diff_entity_type_code := le.entity_type_code <> ri.entity_type_code;
    SELF.Diff_companyname := le.companyname <> ri.companyname;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_source_rid := le.source_rid <> ri.source_rid;
    SELF.Diff_lnpid := le.lnpid <> ri.lnpid;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_nid := le.nid <> ri.nid;
    SELF.Diff_clean_clinic_name := le.clean_clinic_name <> ri.clean_clinic_name;
    SELF.Diff_prepped_addr1 := le.prepped_addr1 <> ri.prepped_addr1;
    SELF.Diff_prepped_addr2 := le.prepped_addr2 <> ri.prepped_addr2;
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
    SELF.Diff_fips_st := le.fips_st <> ri.fips_st;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_aceaid := le.aceaid <> ri.aceaid;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_best_dob,1,0)+ IF( SELF.Diff_best_ssn,1,0)+ IF( SELF.Diff_data_state,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_citystate,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_providertypedesc,1,0)+ IF( SELF.Diff_medicaidid,1,0)+ IF( SELF.Diff_npi,1,0)+ IF( SELF.Diff_entity_type_code,1,0)+ IF( SELF.Diff_companyname,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_source_rid,1,0)+ IF( SELF.Diff_lnpid,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_nid,1,0)+ IF( SELF.Diff_clean_clinic_name,1,0)+ IF( SELF.Diff_prepped_addr1,1,0)+ IF( SELF.Diff_prepped_addr2,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_st,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_aceaid,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0);
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
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_best_dob := COUNT(GROUP,%Closest%.Diff_best_dob);
    Count_Diff_best_ssn := COUNT(GROUP,%Closest%.Diff_best_ssn);
    Count_Diff_data_state := COUNT(GROUP,%Closest%.Diff_data_state);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_citystate := COUNT(GROUP,%Closest%.Diff_citystate);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_providertypedesc := COUNT(GROUP,%Closest%.Diff_providertypedesc);
    Count_Diff_medicaidid := COUNT(GROUP,%Closest%.Diff_medicaidid);
    Count_Diff_npi := COUNT(GROUP,%Closest%.Diff_npi);
    Count_Diff_entity_type_code := COUNT(GROUP,%Closest%.Diff_entity_type_code);
    Count_Diff_companyname := COUNT(GROUP,%Closest%.Diff_companyname);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_source_rid := COUNT(GROUP,%Closest%.Diff_source_rid);
    Count_Diff_lnpid := COUNT(GROUP,%Closest%.Diff_lnpid);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_nid := COUNT(GROUP,%Closest%.Diff_nid);
    Count_Diff_clean_clinic_name := COUNT(GROUP,%Closest%.Diff_clean_clinic_name);
    Count_Diff_prepped_addr1 := COUNT(GROUP,%Closest%.Diff_prepped_addr1);
    Count_Diff_prepped_addr2 := COUNT(GROUP,%Closest%.Diff_prepped_addr2);
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
    Count_Diff_fips_st := COUNT(GROUP,%Closest%.Diff_fips_st);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_aceaid := COUNT(GROUP,%Closest%.Diff_aceaid);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
