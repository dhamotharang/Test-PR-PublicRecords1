IMPORT ut,SALT32;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'mbslayout_company_id','mbslayout_global_company_id','allowlayout_allowflags','businfolayout_primary_market_code','businfolayout_secondary_market_code','businfolayout_industry_1_code','businfolayout_industry_2_code','businfolayout_sub_market','businfolayout_vertical','businfolayout_use','businfolayout_industry','persondatalayout_full_name','persondatalayout_first_name','persondatalayout_middle_name','persondatalayout_last_name','persondatalayout_address','persondatalayout_city','persondatalayout_state','persondatalayout_zip','persondatalayout_personal_phone','persondatalayout_work_phone','persondatalayout_dob','persondatalayout_dl','persondatalayout_dl_st','persondatalayout_email_address','persondatalayout_ssn','persondatalayout_linkid','persondatalayout_ipaddr','persondatalayout_title','persondatalayout_fname','persondatalayout_mname','persondatalayout_lname','persondatalayout_name_suffix','persondatalayout_prim_range','persondatalayout_predir','persondatalayout_prim_name','persondatalayout_addr_suffix','persondatalayout_postdir','persondatalayout_unit_desig','persondatalayout_sec_range','persondatalayout_v_city_name','persondatalayout_st','persondatalayout_zip5','persondatalayout_zip4','persondatalayout_addr_rec_type','persondatalayout_fips_state','persondatalayout_fips_county','persondatalayout_geo_lat','persondatalayout_geo_long','persondatalayout_cbsa','persondatalayout_geo_blk','persondatalayout_geo_match','persondatalayout_err_stat','persondatalayout_appended_ssn','persondatalayout_appended_adl','permissablelayout_glb_purpose','permissablelayout_dppa_purpose','permissablelayout_fcra_purpose','searchlayout_datetime','searchlayout_start_monitor','searchlayout_stop_monitor','searchlayout_login_history_id','searchlayout_transaction_id','searchlayout_sequence_number','searchlayout_method','searchlayout_product_code','searchlayout_transaction_type','searchlayout_function_description','searchlayout_ipaddr','fraudpoint_score');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'mbslayout_company_id' => 1,'mbslayout_global_company_id' => 2,'allowlayout_allowflags' => 3,'businfolayout_primary_market_code' => 4,'businfolayout_secondary_market_code' => 5,'businfolayout_industry_1_code' => 6,'businfolayout_industry_2_code' => 7,'businfolayout_sub_market' => 8,'businfolayout_vertical' => 9,'businfolayout_use' => 10,'businfolayout_industry' => 11,'persondatalayout_full_name' => 12,'persondatalayout_first_name' => 13,'persondatalayout_middle_name' => 14,'persondatalayout_last_name' => 15,'persondatalayout_address' => 16,'persondatalayout_city' => 17,'persondatalayout_state' => 18,'persondatalayout_zip' => 19,'persondatalayout_personal_phone' => 20,'persondatalayout_work_phone' => 21,'persondatalayout_dob' => 22,'persondatalayout_dl' => 23,'persondatalayout_dl_st' => 24,'persondatalayout_email_address' => 25,'persondatalayout_ssn' => 26,'persondatalayout_linkid' => 27,'persondatalayout_ipaddr' => 28,'persondatalayout_title' => 29,'persondatalayout_fname' => 30,'persondatalayout_mname' => 31,'persondatalayout_lname' => 32,'persondatalayout_name_suffix' => 33,'persondatalayout_prim_range' => 34,'persondatalayout_predir' => 35,'persondatalayout_prim_name' => 36,'persondatalayout_addr_suffix' => 37,'persondatalayout_postdir' => 38,'persondatalayout_unit_desig' => 39,'persondatalayout_sec_range' => 40,'persondatalayout_v_city_name' => 41,'persondatalayout_st' => 42,'persondatalayout_zip5' => 43,'persondatalayout_zip4' => 44,'persondatalayout_addr_rec_type' => 45,'persondatalayout_fips_state' => 46,'persondatalayout_fips_county' => 47,'persondatalayout_geo_lat' => 48,'persondatalayout_geo_long' => 49,'persondatalayout_cbsa' => 50,'persondatalayout_geo_blk' => 51,'persondatalayout_geo_match' => 52,'persondatalayout_err_stat' => 53,'persondatalayout_appended_ssn' => 54,'persondatalayout_appended_adl' => 55,'permissablelayout_glb_purpose' => 56,'permissablelayout_dppa_purpose' => 57,'permissablelayout_fcra_purpose' => 58,'searchlayout_datetime' => 59,'searchlayout_start_monitor' => 60,'searchlayout_stop_monitor' => 61,'searchlayout_login_history_id' => 62,'searchlayout_transaction_id' => 63,'searchlayout_sequence_number' => 64,'searchlayout_method' => 65,'searchlayout_product_code' => 66,'searchlayout_transaction_type' => 67,'searchlayout_function_description' => 68,'searchlayout_ipaddr' => 69,'fraudpoint_score' => 70,0);
 
EXPORT MakeFT_mbslayout_company_id(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mbslayout_company_id(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mbslayout_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_mbslayout_global_company_id(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mbslayout_global_company_id(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mbslayout_global_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_allowlayout_allowflags(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'13589 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_allowlayout_allowflags(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'13589 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_allowlayout_allowflags(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('13589 '),SALT32.HygieneErrors.NotLength('4,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_businfolayout_primary_market_code(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'39 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_businfolayout_primary_market_code(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'39 '))),~(LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_businfolayout_primary_market_code(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('39 '),SALT32.HygieneErrors.NotLength('2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_businfolayout_secondary_market_code(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'1257GJKLNQRUWY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_businfolayout_secondary_market_code(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'1257GJKLNQRUWY '))),~(LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_businfolayout_secondary_market_code(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('1257GJKLNQRUWY '),SALT32.HygieneErrors.NotLength('2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_businfolayout_industry_1_code(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'012349ABPV '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_businfolayout_industry_1_code(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'012349ABPV '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_businfolayout_industry_1_code(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('012349ABPV '),SALT32.HygieneErrors.NotLength('2,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_businfolayout_industry_2_code(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'013456789ABCEFGKNPRTUXZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_businfolayout_industry_2_code(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'013456789ABCEFGKNPRTUXZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_businfolayout_industry_2_code(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('013456789ABCEFGKNPRTUXZ '),SALT32.HygieneErrors.NotLength('2,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_businfolayout_sub_market(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ./ABCDEFGHILMNOPRSTUVWY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_businfolayout_sub_market(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ./ABCDEFGHILMNOPRSTUVWY '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_businfolayout_sub_market(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ./ABCDEFGHILMNOPRSTUVWY '),SALT32.HygieneErrors.NotLength('8,11,5,14,9,21,19,10,20,7,4,12,6,3,0'),SALT32.HygieneErrors.NotWords('1,2,3'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_businfolayout_vertical(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCEFGIKLMNOPRSTV '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_businfolayout_vertical(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCEFGIKLMNOPRSTV '))),~(LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 22),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_businfolayout_vertical(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCEFGIKLMNOPRSTV '),SALT32.HygieneErrors.NotLength('17,18,22'),SALT32.HygieneErrors.NotWords('2'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_businfolayout_use(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ACKMNOUW '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_businfolayout_use(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ACKMNOUW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 4),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_businfolayout_use(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ACKMNOUW '),SALT32.HygieneErrors.NotLength('0,7,2,4'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_businfolayout_industry(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' -/ABCDEFGHIKLMNOPRSTUVWY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_businfolayout_industry(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' -/ABCDEFGHIKLMNOPRSTUVWY '))),~(LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 9),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_businfolayout_industry(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' -/ABCDEFGHIKLMNOPRSTUVWY '),SALT32.HygieneErrors.NotLength('18,10,5,11,4,7,14,19,20,6,12,13,15,9'),SALT32.HygieneErrors.NotWords('1,3,2'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_full_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_full_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 28),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 4 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 5));
EXPORT InValidMessageFT_persondatalayout_full_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('14,15,13,16,12,17,11,18,0,19,10,20,9,21,22,8,23,7,24,25,6,26,27,29,5,28'),SALT32.HygieneErrors.NotWords('3,2,1,4,5'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_first_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_first_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 12),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_persondatalayout_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('5,6,7,4,0,8,9,3,1,10,11,2,15,12'),SALT32.HygieneErrors.NotWords('1,2'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_middle_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' .ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_middle_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' .ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_persondatalayout_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' .ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT32.HygieneErrors.NotLength('0,1,5,6,4,3,7,8,9,2'),SALT32.HygieneErrors.NotWords('1,2'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_last_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_last_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 19),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_persondatalayout_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('6,5,7,0,8,4,9,10,3,11,12,13,1,2,14,15,20,16,17,19'),SALT32.HygieneErrors.NotWords('1,2,3'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_address(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_address(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 30 OR LENGTH(TRIM(s)) = 31 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 32 OR LENGTH(TRIM(s)) = 33 OR LENGTH(TRIM(s)) = 34 OR LENGTH(TRIM(s)) = 35 OR LENGTH(TRIM(s)) = 7),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 4 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 5 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 6 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 7 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_persondatalayout_address(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('0,15,16,14,17,13,18,19,12,20,21,11,22,10,23,24,25,26,27,9,28,29,30,31,8,32,33,34,35,7'),SALT32.HygieneErrors.NotWords('3,4,1,5,6,7,2'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_city(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_city(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 20),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_persondatalayout_city(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT32.HygieneErrors.NotLength('0,7,8,9,6,10,11,12,5,13,14,4,16,15,17,18,19,3,20'),SALT32.HygieneErrors.NotWords('1,2,3'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_state(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_state(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_state(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('2,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_zip(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_zip(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('9,0,5,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_personal_phone(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_persondatalayout_personal_phone(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_personal_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('0,10'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_work_phone(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,',0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_persondatalayout_work_phone(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,',0123456789 '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_work_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars(',0123456789 '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_dob(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_dob(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('0,8'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_dl(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' -0123456789ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_dl(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' -0123456789ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_dl(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' -0123456789ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_dl_st(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'/19ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_dl_st(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'/19ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_dl_st(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('/19ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_email_address(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_email_address(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_email_address(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_ssn(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' 0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_persondatalayout_ssn(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' 0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars(' 0123456789 '),SALT32.HygieneErrors.NotLength('0,9,8'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_linkid(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_linkid(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_linkid(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('0,12,10,9'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_ipaddr(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'.0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_ipaddr(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'.0123456789 '))),~(LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_ipaddr(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('.0123456789 '),SALT32.HygieneErrors.NotLength('14,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_title(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_title(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_title(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_fname(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_persondatalayout_fname(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('5,6,7,4,8,9,0,3,1,10,11,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_mname(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_persondatalayout_mname(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_persondatalayout_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT32.HygieneErrors.NotLength('1,0,5,4,3,6,7,8,9,2'),SALT32.HygieneErrors.NotWords('1,2'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_lname(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_lname(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_persondatalayout_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('6,5,7,8,4,9,0,10,3,11,12,13,1,14,2,15,16,20,17,18'),SALT32.HygieneErrors.NotWords('1,2,3'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_name_suffix(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFHIJKLMNOPRSTUVWY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_persondatalayout_name_suffix(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFHIJKLMNOPRSTUVWY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars(' ABCDEFHIJKLMNOPRSTUVWY '),SALT32.HygieneErrors.NotLength('0,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_prim_range(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' -/0123456789ANW '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_prim_range(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' -/0123456789ANW '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' -/0123456789ANW '),SALT32.HygieneErrors.NotLength('4,3,0,5,2,1,6,7'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_predir(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_predir(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ENSW '),SALT32.HygieneErrors.NotLength('0,1,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_prim_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_prim_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 4));
EXPORT InValidMessageFT_persondatalayout_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('0,7,6,8,5,4,9,10,11,12,3,13,14,15,16,17,1,18,19,20,21,2'),SALT32.HygieneErrors.NotWords('1,2,3,4'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_addr_suffix(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEGHIKLNOPRSTUVWXY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_addr_suffix(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEGHIKLNOPRSTUVWXY '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 4),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ABCDEGHIKLNOPRSTUVWXY '),SALT32.HygieneErrors.NotLength('2,0,3,4'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_postdir(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_postdir(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ENSW '),SALT32.HygieneErrors.NotLength('0,2,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_unit_desig(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFILMNOPRSTUX '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_unit_desig(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFILMNOPRSTUX '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ABCDEFILMNOPRSTUX '),SALT32.HygieneErrors.NotLength('0,3,4,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_sec_range(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'-0123456789ABCDEFGHIJKLMNOPQRSTUW '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_sec_range(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'-0123456789ABCDEFGHIJKLMNOPQRSTUW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('-0123456789ABCDEFGHIJKLMNOPQRSTUW '),SALT32.HygieneErrors.NotLength('0,3,1,2,4,5'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_v_city_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_v_city_name(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 20),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_persondatalayout_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT32.HygieneErrors.NotLength('0,7,8,9,6,10,11,12,5,13,14,4,16,15,17,18,19,3,20'),SALT32.HygieneErrors.NotWords('1,2,3'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_st(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_st(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_st(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT32.HygieneErrors.NotLength('2,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_zip5(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_zip5(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('5,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_zip4(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_zip4(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('4,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_addr_rec_type(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'DFHPRS '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_addr_rec_type(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'DFHPRS '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_addr_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('DFHPRS '),SALT32.HygieneErrors.NotLength('1,0,2'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_fips_state(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_fips_state(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('2,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_fips_county(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_fips_county(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('3,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_geo_lat(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'.0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_geo_lat(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'.0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_geo_lat(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('.0123456789 '),SALT32.HygieneErrors.NotLength('9,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_geo_long(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'-.0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_geo_long(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'-.0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_geo_long(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('-.0123456789 '),SALT32.HygieneErrors.NotLength('10,11,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_cbsa(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_cbsa(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_cbsa(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_geo_blk(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_geo_blk(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('7,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_geo_match(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0145 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_geo_match(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0145 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0145 '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_err_stat(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'012348AES '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_err_stat(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'012348AES '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('012348AES '),SALT32.HygieneErrors.NotLength('4,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_appended_ssn(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_appended_ssn(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_appended_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('9,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_persondatalayout_appended_adl(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_persondatalayout_appended_adl(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_persondatalayout_appended_adl(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('10,0,9,12,11,8,7'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_permissablelayout_glb_purpose(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0135678 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_permissablelayout_glb_purpose(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0135678 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_permissablelayout_glb_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0135678 '),SALT32.HygieneErrors.NotLength('1,2,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_permissablelayout_dppa_purpose(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0134 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_permissablelayout_dppa_purpose(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0134 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_permissablelayout_dppa_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0134 '),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_permissablelayout_fcra_purpose(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_permissablelayout_fcra_purpose(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_permissablelayout_fcra_purpose(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0 '),SALT32.HygieneErrors.NotLength('0,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_datetime(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' 0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_datetime(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' 0123456789 '))),~(LENGTH(TRIM(s)) = 17),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_searchlayout_datetime(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' 0123456789 '),SALT32.HygieneErrors.NotLength('17'),SALT32.HygieneErrors.NotWords('2'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_start_monitor(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_start_monitor(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_searchlayout_start_monitor(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_stop_monitor(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_stop_monitor(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_searchlayout_stop_monitor(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' '),SALT32.HygieneErrors.NotLength('0'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_login_history_id(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_login_history_id(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 9),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_searchlayout_login_history_id(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('0,1,9'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_transaction_id(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789R '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_transaction_id(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789R '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 14),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_searchlayout_transaction_id(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789R '),SALT32.HygieneErrors.NotLength('9,15,16,14'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_sequence_number(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_sequence_number(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 14),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_searchlayout_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('7,6,5,8,4,0,3,2,13,1,14'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_method(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCGHILMNORTX '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_method(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCGHILMNORTX '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 6),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_searchlayout_method(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('ABCGHILMNORTX '),SALT32.HygieneErrors.NotLength('5,3,0,10,6'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_product_code(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'15 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_product_code(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'15 '))),~(LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_searchlayout_product_code(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('15 '),SALT32.HygieneErrors.NotLength('1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_transaction_type(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'IRST '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_transaction_type(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'IRST '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_searchlayout_transaction_type(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('IRST '),SALT32.HygieneErrors.NotLength('0,1'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_function_description(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' .ABCDEFGHIKLMNOPRSTUVW '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_function_description(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' .ABCDEFGHIKLMNOPRSTUVW '))),~(LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 31 OR LENGTH(TRIM(s)) = 32 OR LENGTH(TRIM(s)) = 49 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 45 OR LENGTH(TRIM(s)) = 40 OR LENGTH(TRIM(s)) = 57 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 43 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 36 OR LENGTH(TRIM(s)) = 33 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 70 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 42 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 41 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 8),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 2 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 3 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 4 OR SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 7));
EXPORT InValidMessageFT_searchlayout_function_description(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars(' .ABCDEFGHIKLMNOPRSTUVW '),SALT32.HygieneErrors.NotLength('27,31,32,49,22,29,45,40,57,19,13,10,15,43,18,36,33,24,70,0,21,42,12,6,17,11,41,23,20,16,8'),SALT32.HygieneErrors.NotWords('1,2,3,4,7'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_searchlayout_ipaddr(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'.0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_searchlayout_ipaddr(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'.0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 11),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_searchlayout_ipaddr(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('.0123456789 '),SALT32.HygieneErrors.NotLength('0,14,13,12,15,11'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_fraudpoint_score(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fraudpoint_score(SALT32.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3),~(SALT32.WordCount(SALT32.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_fraudpoint_score(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLeft,SALT32.HygieneErrors.NotInChars('0123456789 '),SALT32.HygieneErrors.NotLength('0,3'),SALT32.HygieneErrors.NotWords('1'),SALT32.HygieneErrors.Good);
 
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'mbslayout_company_id','mbslayout_global_company_id','allowlayout_allowflags','businfolayout_primary_market_code','businfolayout_secondary_market_code','businfolayout_industry_1_code','businfolayout_industry_2_code','businfolayout_sub_market','businfolayout_vertical','businfolayout_use','businfolayout_industry','persondatalayout_full_name','persondatalayout_first_name','persondatalayout_middle_name','persondatalayout_last_name','persondatalayout_address','persondatalayout_city','persondatalayout_state','persondatalayout_zip','persondatalayout_personal_phone','persondatalayout_work_phone','persondatalayout_dob','persondatalayout_dl','persondatalayout_dl_st','persondatalayout_email_address','persondatalayout_ssn','persondatalayout_linkid','persondatalayout_ipaddr','persondatalayout_title','persondatalayout_fname','persondatalayout_mname','persondatalayout_lname','persondatalayout_name_suffix','persondatalayout_prim_range','persondatalayout_predir','persondatalayout_prim_name','persondatalayout_addr_suffix','persondatalayout_postdir','persondatalayout_unit_desig','persondatalayout_sec_range','persondatalayout_v_city_name','persondatalayout_st','persondatalayout_zip5','persondatalayout_zip4','persondatalayout_addr_rec_type','persondatalayout_fips_state','persondatalayout_fips_county','persondatalayout_geo_lat','persondatalayout_geo_long','persondatalayout_cbsa','persondatalayout_geo_blk','persondatalayout_geo_match','persondatalayout_err_stat','persondatalayout_appended_ssn','persondatalayout_appended_adl','permissablelayout_glb_purpose','permissablelayout_dppa_purpose','permissablelayout_fcra_purpose','searchlayout_datetime','searchlayout_start_monitor','searchlayout_stop_monitor','searchlayout_login_history_id','searchlayout_transaction_id','searchlayout_sequence_number','searchlayout_method','searchlayout_product_code','searchlayout_transaction_type','searchlayout_function_description','searchlayout_ipaddr','fraudpoint_score');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'mbslayout_company_id' => 0,'mbslayout_global_company_id' => 1,'allowlayout_allowflags' => 2,'businfolayout_primary_market_code' => 3,'businfolayout_secondary_market_code' => 4,'businfolayout_industry_1_code' => 5,'businfolayout_industry_2_code' => 6,'businfolayout_sub_market' => 7,'businfolayout_vertical' => 8,'businfolayout_use' => 9,'businfolayout_industry' => 10,'persondatalayout_full_name' => 11,'persondatalayout_first_name' => 12,'persondatalayout_middle_name' => 13,'persondatalayout_last_name' => 14,'persondatalayout_address' => 15,'persondatalayout_city' => 16,'persondatalayout_state' => 17,'persondatalayout_zip' => 18,'persondatalayout_personal_phone' => 19,'persondatalayout_work_phone' => 20,'persondatalayout_dob' => 21,'persondatalayout_dl' => 22,'persondatalayout_dl_st' => 23,'persondatalayout_email_address' => 24,'persondatalayout_ssn' => 25,'persondatalayout_linkid' => 26,'persondatalayout_ipaddr' => 27,'persondatalayout_title' => 28,'persondatalayout_fname' => 29,'persondatalayout_mname' => 30,'persondatalayout_lname' => 31,'persondatalayout_name_suffix' => 32,'persondatalayout_prim_range' => 33,'persondatalayout_predir' => 34,'persondatalayout_prim_name' => 35,'persondatalayout_addr_suffix' => 36,'persondatalayout_postdir' => 37,'persondatalayout_unit_desig' => 38,'persondatalayout_sec_range' => 39,'persondatalayout_v_city_name' => 40,'persondatalayout_st' => 41,'persondatalayout_zip5' => 42,'persondatalayout_zip4' => 43,'persondatalayout_addr_rec_type' => 44,'persondatalayout_fips_state' => 45,'persondatalayout_fips_county' => 46,'persondatalayout_geo_lat' => 47,'persondatalayout_geo_long' => 48,'persondatalayout_cbsa' => 49,'persondatalayout_geo_blk' => 50,'persondatalayout_geo_match' => 51,'persondatalayout_err_stat' => 52,'persondatalayout_appended_ssn' => 53,'persondatalayout_appended_adl' => 54,'permissablelayout_glb_purpose' => 55,'permissablelayout_dppa_purpose' => 56,'permissablelayout_fcra_purpose' => 57,'searchlayout_datetime' => 58,'searchlayout_start_monitor' => 59,'searchlayout_stop_monitor' => 60,'searchlayout_login_history_id' => 61,'searchlayout_transaction_id' => 62,'searchlayout_sequence_number' => 63,'searchlayout_method' => 64,'searchlayout_product_code' => 65,'searchlayout_transaction_type' => 66,'searchlayout_function_description' => 67,'searchlayout_ipaddr' => 68,'fraudpoint_score' => 69,0);
 
//Individual field level validation
 
EXPORT Make_mbslayout_company_id(SALT32.StrType s0) := MakeFT_mbslayout_company_id(s0);
EXPORT InValid_mbslayout_company_id(SALT32.StrType s) := InValidFT_mbslayout_company_id(s);
EXPORT InValidMessage_mbslayout_company_id(UNSIGNED1 wh) := InValidMessageFT_mbslayout_company_id(wh);
 
EXPORT Make_mbslayout_global_company_id(SALT32.StrType s0) := MakeFT_mbslayout_global_company_id(s0);
EXPORT InValid_mbslayout_global_company_id(SALT32.StrType s) := InValidFT_mbslayout_global_company_id(s);
EXPORT InValidMessage_mbslayout_global_company_id(UNSIGNED1 wh) := InValidMessageFT_mbslayout_global_company_id(wh);
 
EXPORT Make_allowlayout_allowflags(SALT32.StrType s0) := MakeFT_allowlayout_allowflags(s0);
EXPORT InValid_allowlayout_allowflags(SALT32.StrType s) := InValidFT_allowlayout_allowflags(s);
EXPORT InValidMessage_allowlayout_allowflags(UNSIGNED1 wh) := InValidMessageFT_allowlayout_allowflags(wh);
 
EXPORT Make_businfolayout_primary_market_code(SALT32.StrType s0) := MakeFT_businfolayout_primary_market_code(s0);
EXPORT InValid_businfolayout_primary_market_code(SALT32.StrType s) := InValidFT_businfolayout_primary_market_code(s);
EXPORT InValidMessage_businfolayout_primary_market_code(UNSIGNED1 wh) := InValidMessageFT_businfolayout_primary_market_code(wh);
 
EXPORT Make_businfolayout_secondary_market_code(SALT32.StrType s0) := MakeFT_businfolayout_secondary_market_code(s0);
EXPORT InValid_businfolayout_secondary_market_code(SALT32.StrType s) := InValidFT_businfolayout_secondary_market_code(s);
EXPORT InValidMessage_businfolayout_secondary_market_code(UNSIGNED1 wh) := InValidMessageFT_businfolayout_secondary_market_code(wh);
 
EXPORT Make_businfolayout_industry_1_code(SALT32.StrType s0) := MakeFT_businfolayout_industry_1_code(s0);
EXPORT InValid_businfolayout_industry_1_code(SALT32.StrType s) := InValidFT_businfolayout_industry_1_code(s);
EXPORT InValidMessage_businfolayout_industry_1_code(UNSIGNED1 wh) := InValidMessageFT_businfolayout_industry_1_code(wh);
 
EXPORT Make_businfolayout_industry_2_code(SALT32.StrType s0) := MakeFT_businfolayout_industry_2_code(s0);
EXPORT InValid_businfolayout_industry_2_code(SALT32.StrType s) := InValidFT_businfolayout_industry_2_code(s);
EXPORT InValidMessage_businfolayout_industry_2_code(UNSIGNED1 wh) := InValidMessageFT_businfolayout_industry_2_code(wh);
 
EXPORT Make_businfolayout_sub_market(SALT32.StrType s0) := MakeFT_businfolayout_sub_market(s0);
EXPORT InValid_businfolayout_sub_market(SALT32.StrType s) := InValidFT_businfolayout_sub_market(s);
EXPORT InValidMessage_businfolayout_sub_market(UNSIGNED1 wh) := InValidMessageFT_businfolayout_sub_market(wh);
 
EXPORT Make_businfolayout_vertical(SALT32.StrType s0) := MakeFT_businfolayout_vertical(s0);
EXPORT InValid_businfolayout_vertical(SALT32.StrType s) := InValidFT_businfolayout_vertical(s);
EXPORT InValidMessage_businfolayout_vertical(UNSIGNED1 wh) := InValidMessageFT_businfolayout_vertical(wh);
 
EXPORT Make_businfolayout_use(SALT32.StrType s0) := MakeFT_businfolayout_use(s0);
EXPORT InValid_businfolayout_use(SALT32.StrType s) := InValidFT_businfolayout_use(s);
EXPORT InValidMessage_businfolayout_use(UNSIGNED1 wh) := InValidMessageFT_businfolayout_use(wh);
 
EXPORT Make_businfolayout_industry(SALT32.StrType s0) := MakeFT_businfolayout_industry(s0);
EXPORT InValid_businfolayout_industry(SALT32.StrType s) := InValidFT_businfolayout_industry(s);
EXPORT InValidMessage_businfolayout_industry(UNSIGNED1 wh) := InValidMessageFT_businfolayout_industry(wh);
 
EXPORT Make_persondatalayout_full_name(SALT32.StrType s0) := MakeFT_persondatalayout_full_name(s0);
EXPORT InValid_persondatalayout_full_name(SALT32.StrType s) := InValidFT_persondatalayout_full_name(s);
EXPORT InValidMessage_persondatalayout_full_name(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_full_name(wh);
 
EXPORT Make_persondatalayout_first_name(SALT32.StrType s0) := MakeFT_persondatalayout_first_name(s0);
EXPORT InValid_persondatalayout_first_name(SALT32.StrType s) := InValidFT_persondatalayout_first_name(s);
EXPORT InValidMessage_persondatalayout_first_name(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_first_name(wh);
 
EXPORT Make_persondatalayout_middle_name(SALT32.StrType s0) := MakeFT_persondatalayout_middle_name(s0);
EXPORT InValid_persondatalayout_middle_name(SALT32.StrType s) := InValidFT_persondatalayout_middle_name(s);
EXPORT InValidMessage_persondatalayout_middle_name(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_middle_name(wh);
 
EXPORT Make_persondatalayout_last_name(SALT32.StrType s0) := MakeFT_persondatalayout_last_name(s0);
EXPORT InValid_persondatalayout_last_name(SALT32.StrType s) := InValidFT_persondatalayout_last_name(s);
EXPORT InValidMessage_persondatalayout_last_name(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_last_name(wh);
 
EXPORT Make_persondatalayout_address(SALT32.StrType s0) := MakeFT_persondatalayout_address(s0);
EXPORT InValid_persondatalayout_address(SALT32.StrType s) := InValidFT_persondatalayout_address(s);
EXPORT InValidMessage_persondatalayout_address(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_address(wh);
 
EXPORT Make_persondatalayout_city(SALT32.StrType s0) := MakeFT_persondatalayout_city(s0);
EXPORT InValid_persondatalayout_city(SALT32.StrType s) := InValidFT_persondatalayout_city(s);
EXPORT InValidMessage_persondatalayout_city(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_city(wh);
 
EXPORT Make_persondatalayout_state(SALT32.StrType s0) := MakeFT_persondatalayout_state(s0);
EXPORT InValid_persondatalayout_state(SALT32.StrType s) := InValidFT_persondatalayout_state(s);
EXPORT InValidMessage_persondatalayout_state(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_state(wh);
 
EXPORT Make_persondatalayout_zip(SALT32.StrType s0) := MakeFT_persondatalayout_zip(s0);
EXPORT InValid_persondatalayout_zip(SALT32.StrType s) := InValidFT_persondatalayout_zip(s);
EXPORT InValidMessage_persondatalayout_zip(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_zip(wh);
 
EXPORT Make_persondatalayout_personal_phone(SALT32.StrType s0) := MakeFT_persondatalayout_personal_phone(s0);
EXPORT InValid_persondatalayout_personal_phone(SALT32.StrType s) := InValidFT_persondatalayout_personal_phone(s);
EXPORT InValidMessage_persondatalayout_personal_phone(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_personal_phone(wh);
 
EXPORT Make_persondatalayout_work_phone(SALT32.StrType s0) := MakeFT_persondatalayout_work_phone(s0);
EXPORT InValid_persondatalayout_work_phone(SALT32.StrType s) := InValidFT_persondatalayout_work_phone(s);
EXPORT InValidMessage_persondatalayout_work_phone(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_work_phone(wh);
 
EXPORT Make_persondatalayout_dob(SALT32.StrType s0) := MakeFT_persondatalayout_dob(s0);
EXPORT InValid_persondatalayout_dob(SALT32.StrType s) := InValidFT_persondatalayout_dob(s);
EXPORT InValidMessage_persondatalayout_dob(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_dob(wh);
 
EXPORT Make_persondatalayout_dl(SALT32.StrType s0) := MakeFT_persondatalayout_dl(s0);
EXPORT InValid_persondatalayout_dl(SALT32.StrType s) := InValidFT_persondatalayout_dl(s);
EXPORT InValidMessage_persondatalayout_dl(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_dl(wh);
 
EXPORT Make_persondatalayout_dl_st(SALT32.StrType s0) := MakeFT_persondatalayout_dl_st(s0);
EXPORT InValid_persondatalayout_dl_st(SALT32.StrType s) := InValidFT_persondatalayout_dl_st(s);
EXPORT InValidMessage_persondatalayout_dl_st(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_dl_st(wh);
 
EXPORT Make_persondatalayout_email_address(SALT32.StrType s0) := MakeFT_persondatalayout_email_address(s0);
EXPORT InValid_persondatalayout_email_address(SALT32.StrType s) := InValidFT_persondatalayout_email_address(s);
EXPORT InValidMessage_persondatalayout_email_address(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_email_address(wh);
 
EXPORT Make_persondatalayout_ssn(SALT32.StrType s0) := MakeFT_persondatalayout_ssn(s0);
EXPORT InValid_persondatalayout_ssn(SALT32.StrType s) := InValidFT_persondatalayout_ssn(s);
EXPORT InValidMessage_persondatalayout_ssn(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_ssn(wh);
 
EXPORT Make_persondatalayout_linkid(SALT32.StrType s0) := MakeFT_persondatalayout_linkid(s0);
EXPORT InValid_persondatalayout_linkid(SALT32.StrType s) := InValidFT_persondatalayout_linkid(s);
EXPORT InValidMessage_persondatalayout_linkid(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_linkid(wh);
 
EXPORT Make_persondatalayout_ipaddr(SALT32.StrType s0) := MakeFT_persondatalayout_ipaddr(s0);
EXPORT InValid_persondatalayout_ipaddr(SALT32.StrType s) := InValidFT_persondatalayout_ipaddr(s);
EXPORT InValidMessage_persondatalayout_ipaddr(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_ipaddr(wh);
 
EXPORT Make_persondatalayout_title(SALT32.StrType s0) := MakeFT_persondatalayout_title(s0);
EXPORT InValid_persondatalayout_title(SALT32.StrType s) := InValidFT_persondatalayout_title(s);
EXPORT InValidMessage_persondatalayout_title(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_title(wh);
 
EXPORT Make_persondatalayout_fname(SALT32.StrType s0) := MakeFT_persondatalayout_fname(s0);
EXPORT InValid_persondatalayout_fname(SALT32.StrType s) := InValidFT_persondatalayout_fname(s);
EXPORT InValidMessage_persondatalayout_fname(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_fname(wh);
 
EXPORT Make_persondatalayout_mname(SALT32.StrType s0) := MakeFT_persondatalayout_mname(s0);
EXPORT InValid_persondatalayout_mname(SALT32.StrType s) := InValidFT_persondatalayout_mname(s);
EXPORT InValidMessage_persondatalayout_mname(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_mname(wh);
 
EXPORT Make_persondatalayout_lname(SALT32.StrType s0) := MakeFT_persondatalayout_lname(s0);
EXPORT InValid_persondatalayout_lname(SALT32.StrType s) := InValidFT_persondatalayout_lname(s);
EXPORT InValidMessage_persondatalayout_lname(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_lname(wh);
 
EXPORT Make_persondatalayout_name_suffix(SALT32.StrType s0) := MakeFT_persondatalayout_name_suffix(s0);
EXPORT InValid_persondatalayout_name_suffix(SALT32.StrType s) := InValidFT_persondatalayout_name_suffix(s);
EXPORT InValidMessage_persondatalayout_name_suffix(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_name_suffix(wh);
 
EXPORT Make_persondatalayout_prim_range(SALT32.StrType s0) := MakeFT_persondatalayout_prim_range(s0);
EXPORT InValid_persondatalayout_prim_range(SALT32.StrType s) := InValidFT_persondatalayout_prim_range(s);
EXPORT InValidMessage_persondatalayout_prim_range(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_prim_range(wh);
 
EXPORT Make_persondatalayout_predir(SALT32.StrType s0) := MakeFT_persondatalayout_predir(s0);
EXPORT InValid_persondatalayout_predir(SALT32.StrType s) := InValidFT_persondatalayout_predir(s);
EXPORT InValidMessage_persondatalayout_predir(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_predir(wh);
 
EXPORT Make_persondatalayout_prim_name(SALT32.StrType s0) := MakeFT_persondatalayout_prim_name(s0);
EXPORT InValid_persondatalayout_prim_name(SALT32.StrType s) := InValidFT_persondatalayout_prim_name(s);
EXPORT InValidMessage_persondatalayout_prim_name(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_prim_name(wh);
 
EXPORT Make_persondatalayout_addr_suffix(SALT32.StrType s0) := MakeFT_persondatalayout_addr_suffix(s0);
EXPORT InValid_persondatalayout_addr_suffix(SALT32.StrType s) := InValidFT_persondatalayout_addr_suffix(s);
EXPORT InValidMessage_persondatalayout_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_addr_suffix(wh);
 
EXPORT Make_persondatalayout_postdir(SALT32.StrType s0) := MakeFT_persondatalayout_postdir(s0);
EXPORT InValid_persondatalayout_postdir(SALT32.StrType s) := InValidFT_persondatalayout_postdir(s);
EXPORT InValidMessage_persondatalayout_postdir(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_postdir(wh);
 
EXPORT Make_persondatalayout_unit_desig(SALT32.StrType s0) := MakeFT_persondatalayout_unit_desig(s0);
EXPORT InValid_persondatalayout_unit_desig(SALT32.StrType s) := InValidFT_persondatalayout_unit_desig(s);
EXPORT InValidMessage_persondatalayout_unit_desig(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_unit_desig(wh);
 
EXPORT Make_persondatalayout_sec_range(SALT32.StrType s0) := MakeFT_persondatalayout_sec_range(s0);
EXPORT InValid_persondatalayout_sec_range(SALT32.StrType s) := InValidFT_persondatalayout_sec_range(s);
EXPORT InValidMessage_persondatalayout_sec_range(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_sec_range(wh);
 
EXPORT Make_persondatalayout_v_city_name(SALT32.StrType s0) := MakeFT_persondatalayout_v_city_name(s0);
EXPORT InValid_persondatalayout_v_city_name(SALT32.StrType s) := InValidFT_persondatalayout_v_city_name(s);
EXPORT InValidMessage_persondatalayout_v_city_name(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_v_city_name(wh);
 
EXPORT Make_persondatalayout_st(SALT32.StrType s0) := MakeFT_persondatalayout_st(s0);
EXPORT InValid_persondatalayout_st(SALT32.StrType s) := InValidFT_persondatalayout_st(s);
EXPORT InValidMessage_persondatalayout_st(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_st(wh);
 
EXPORT Make_persondatalayout_zip5(SALT32.StrType s0) := MakeFT_persondatalayout_zip5(s0);
EXPORT InValid_persondatalayout_zip5(SALT32.StrType s) := InValidFT_persondatalayout_zip5(s);
EXPORT InValidMessage_persondatalayout_zip5(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_zip5(wh);
 
EXPORT Make_persondatalayout_zip4(SALT32.StrType s0) := MakeFT_persondatalayout_zip4(s0);
EXPORT InValid_persondatalayout_zip4(SALT32.StrType s) := InValidFT_persondatalayout_zip4(s);
EXPORT InValidMessage_persondatalayout_zip4(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_zip4(wh);
 
EXPORT Make_persondatalayout_addr_rec_type(SALT32.StrType s0) := MakeFT_persondatalayout_addr_rec_type(s0);
EXPORT InValid_persondatalayout_addr_rec_type(SALT32.StrType s) := InValidFT_persondatalayout_addr_rec_type(s);
EXPORT InValidMessage_persondatalayout_addr_rec_type(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_addr_rec_type(wh);
 
EXPORT Make_persondatalayout_fips_state(SALT32.StrType s0) := MakeFT_persondatalayout_fips_state(s0);
EXPORT InValid_persondatalayout_fips_state(SALT32.StrType s) := InValidFT_persondatalayout_fips_state(s);
EXPORT InValidMessage_persondatalayout_fips_state(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_fips_state(wh);
 
EXPORT Make_persondatalayout_fips_county(SALT32.StrType s0) := MakeFT_persondatalayout_fips_county(s0);
EXPORT InValid_persondatalayout_fips_county(SALT32.StrType s) := InValidFT_persondatalayout_fips_county(s);
EXPORT InValidMessage_persondatalayout_fips_county(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_fips_county(wh);
 
EXPORT Make_persondatalayout_geo_lat(SALT32.StrType s0) := MakeFT_persondatalayout_geo_lat(s0);
EXPORT InValid_persondatalayout_geo_lat(SALT32.StrType s) := InValidFT_persondatalayout_geo_lat(s);
EXPORT InValidMessage_persondatalayout_geo_lat(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_geo_lat(wh);
 
EXPORT Make_persondatalayout_geo_long(SALT32.StrType s0) := MakeFT_persondatalayout_geo_long(s0);
EXPORT InValid_persondatalayout_geo_long(SALT32.StrType s) := InValidFT_persondatalayout_geo_long(s);
EXPORT InValidMessage_persondatalayout_geo_long(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_geo_long(wh);
 
EXPORT Make_persondatalayout_cbsa(SALT32.StrType s0) := MakeFT_persondatalayout_cbsa(s0);
EXPORT InValid_persondatalayout_cbsa(SALT32.StrType s) := InValidFT_persondatalayout_cbsa(s);
EXPORT InValidMessage_persondatalayout_cbsa(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_cbsa(wh);
 
EXPORT Make_persondatalayout_geo_blk(SALT32.StrType s0) := MakeFT_persondatalayout_geo_blk(s0);
EXPORT InValid_persondatalayout_geo_blk(SALT32.StrType s) := InValidFT_persondatalayout_geo_blk(s);
EXPORT InValidMessage_persondatalayout_geo_blk(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_geo_blk(wh);
 
EXPORT Make_persondatalayout_geo_match(SALT32.StrType s0) := MakeFT_persondatalayout_geo_match(s0);
EXPORT InValid_persondatalayout_geo_match(SALT32.StrType s) := InValidFT_persondatalayout_geo_match(s);
EXPORT InValidMessage_persondatalayout_geo_match(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_geo_match(wh);
 
EXPORT Make_persondatalayout_err_stat(SALT32.StrType s0) := MakeFT_persondatalayout_err_stat(s0);
EXPORT InValid_persondatalayout_err_stat(SALT32.StrType s) := InValidFT_persondatalayout_err_stat(s);
EXPORT InValidMessage_persondatalayout_err_stat(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_err_stat(wh);
 
EXPORT Make_persondatalayout_appended_ssn(SALT32.StrType s0) := MakeFT_persondatalayout_appended_ssn(s0);
EXPORT InValid_persondatalayout_appended_ssn(SALT32.StrType s) := InValidFT_persondatalayout_appended_ssn(s);
EXPORT InValidMessage_persondatalayout_appended_ssn(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_appended_ssn(wh);
 
EXPORT Make_persondatalayout_appended_adl(SALT32.StrType s0) := MakeFT_persondatalayout_appended_adl(s0);
EXPORT InValid_persondatalayout_appended_adl(SALT32.StrType s) := InValidFT_persondatalayout_appended_adl(s);
EXPORT InValidMessage_persondatalayout_appended_adl(UNSIGNED1 wh) := InValidMessageFT_persondatalayout_appended_adl(wh);
 
EXPORT Make_permissablelayout_glb_purpose(SALT32.StrType s0) := MakeFT_permissablelayout_glb_purpose(s0);
EXPORT InValid_permissablelayout_glb_purpose(SALT32.StrType s) := InValidFT_permissablelayout_glb_purpose(s);
EXPORT InValidMessage_permissablelayout_glb_purpose(UNSIGNED1 wh) := InValidMessageFT_permissablelayout_glb_purpose(wh);
 
EXPORT Make_permissablelayout_dppa_purpose(SALT32.StrType s0) := MakeFT_permissablelayout_dppa_purpose(s0);
EXPORT InValid_permissablelayout_dppa_purpose(SALT32.StrType s) := InValidFT_permissablelayout_dppa_purpose(s);
EXPORT InValidMessage_permissablelayout_dppa_purpose(UNSIGNED1 wh) := InValidMessageFT_permissablelayout_dppa_purpose(wh);
 
EXPORT Make_permissablelayout_fcra_purpose(SALT32.StrType s0) := MakeFT_permissablelayout_fcra_purpose(s0);
EXPORT InValid_permissablelayout_fcra_purpose(SALT32.StrType s) := InValidFT_permissablelayout_fcra_purpose(s);
EXPORT InValidMessage_permissablelayout_fcra_purpose(UNSIGNED1 wh) := InValidMessageFT_permissablelayout_fcra_purpose(wh);
 
EXPORT Make_searchlayout_datetime(SALT32.StrType s0) := MakeFT_searchlayout_datetime(s0);
EXPORT InValid_searchlayout_datetime(SALT32.StrType s) := InValidFT_searchlayout_datetime(s);
EXPORT InValidMessage_searchlayout_datetime(UNSIGNED1 wh) := InValidMessageFT_searchlayout_datetime(wh);
 
EXPORT Make_searchlayout_start_monitor(SALT32.StrType s0) := MakeFT_searchlayout_start_monitor(s0);
EXPORT InValid_searchlayout_start_monitor(SALT32.StrType s) := InValidFT_searchlayout_start_monitor(s);
EXPORT InValidMessage_searchlayout_start_monitor(UNSIGNED1 wh) := InValidMessageFT_searchlayout_start_monitor(wh);
 
EXPORT Make_searchlayout_stop_monitor(SALT32.StrType s0) := MakeFT_searchlayout_stop_monitor(s0);
EXPORT InValid_searchlayout_stop_monitor(SALT32.StrType s) := InValidFT_searchlayout_stop_monitor(s);
EXPORT InValidMessage_searchlayout_stop_monitor(UNSIGNED1 wh) := InValidMessageFT_searchlayout_stop_monitor(wh);
 
EXPORT Make_searchlayout_login_history_id(SALT32.StrType s0) := MakeFT_searchlayout_login_history_id(s0);
EXPORT InValid_searchlayout_login_history_id(SALT32.StrType s) := InValidFT_searchlayout_login_history_id(s);
EXPORT InValidMessage_searchlayout_login_history_id(UNSIGNED1 wh) := InValidMessageFT_searchlayout_login_history_id(wh);
 
EXPORT Make_searchlayout_transaction_id(SALT32.StrType s0) := MakeFT_searchlayout_transaction_id(s0);
EXPORT InValid_searchlayout_transaction_id(SALT32.StrType s) := InValidFT_searchlayout_transaction_id(s);
EXPORT InValidMessage_searchlayout_transaction_id(UNSIGNED1 wh) := InValidMessageFT_searchlayout_transaction_id(wh);
 
EXPORT Make_searchlayout_sequence_number(SALT32.StrType s0) := MakeFT_searchlayout_sequence_number(s0);
EXPORT InValid_searchlayout_sequence_number(SALT32.StrType s) := InValidFT_searchlayout_sequence_number(s);
EXPORT InValidMessage_searchlayout_sequence_number(UNSIGNED1 wh) := InValidMessageFT_searchlayout_sequence_number(wh);
 
EXPORT Make_searchlayout_method(SALT32.StrType s0) := MakeFT_searchlayout_method(s0);
EXPORT InValid_searchlayout_method(SALT32.StrType s) := InValidFT_searchlayout_method(s);
EXPORT InValidMessage_searchlayout_method(UNSIGNED1 wh) := InValidMessageFT_searchlayout_method(wh);
 
EXPORT Make_searchlayout_product_code(SALT32.StrType s0) := MakeFT_searchlayout_product_code(s0);
EXPORT InValid_searchlayout_product_code(SALT32.StrType s) := InValidFT_searchlayout_product_code(s);
EXPORT InValidMessage_searchlayout_product_code(UNSIGNED1 wh) := InValidMessageFT_searchlayout_product_code(wh);
 
EXPORT Make_searchlayout_transaction_type(SALT32.StrType s0) := MakeFT_searchlayout_transaction_type(s0);
EXPORT InValid_searchlayout_transaction_type(SALT32.StrType s) := InValidFT_searchlayout_transaction_type(s);
EXPORT InValidMessage_searchlayout_transaction_type(UNSIGNED1 wh) := InValidMessageFT_searchlayout_transaction_type(wh);
 
EXPORT Make_searchlayout_function_description(SALT32.StrType s0) := MakeFT_searchlayout_function_description(s0);
EXPORT InValid_searchlayout_function_description(SALT32.StrType s) := InValidFT_searchlayout_function_description(s);
EXPORT InValidMessage_searchlayout_function_description(UNSIGNED1 wh) := InValidMessageFT_searchlayout_function_description(wh);
 
EXPORT Make_searchlayout_ipaddr(SALT32.StrType s0) := MakeFT_searchlayout_ipaddr(s0);
EXPORT InValid_searchlayout_ipaddr(SALT32.StrType s) := InValidFT_searchlayout_ipaddr(s);
EXPORT InValidMessage_searchlayout_ipaddr(UNSIGNED1 wh) := InValidMessageFT_searchlayout_ipaddr(wh);
 
EXPORT Make_fraudpoint_score(SALT32.StrType s0) := MakeFT_fraudpoint_score(s0);
EXPORT InValid_fraudpoint_score(SALT32.StrType s) := InValidFT_fraudpoint_score(s);
EXPORT InValidMessage_fraudpoint_score(UNSIGNED1 wh) := InValidMessageFT_fraudpoint_score(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,Scrubs_Inquiry_AccLogs_Update;
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
    BOOLEAN Diff_mbslayout_company_id;
    BOOLEAN Diff_mbslayout_global_company_id;
    BOOLEAN Diff_allowlayout_allowflags;
    BOOLEAN Diff_businfolayout_primary_market_code;
    BOOLEAN Diff_businfolayout_secondary_market_code;
    BOOLEAN Diff_businfolayout_industry_1_code;
    BOOLEAN Diff_businfolayout_industry_2_code;
    BOOLEAN Diff_businfolayout_sub_market;
    BOOLEAN Diff_businfolayout_vertical;
    BOOLEAN Diff_businfolayout_use;
    BOOLEAN Diff_businfolayout_industry;
    BOOLEAN Diff_persondatalayout_full_name;
    BOOLEAN Diff_persondatalayout_first_name;
    BOOLEAN Diff_persondatalayout_middle_name;
    BOOLEAN Diff_persondatalayout_last_name;
    BOOLEAN Diff_persondatalayout_address;
    BOOLEAN Diff_persondatalayout_city;
    BOOLEAN Diff_persondatalayout_state;
    BOOLEAN Diff_persondatalayout_zip;
    BOOLEAN Diff_persondatalayout_personal_phone;
    BOOLEAN Diff_persondatalayout_work_phone;
    BOOLEAN Diff_persondatalayout_dob;
    BOOLEAN Diff_persondatalayout_dl;
    BOOLEAN Diff_persondatalayout_dl_st;
    BOOLEAN Diff_persondatalayout_email_address;
    BOOLEAN Diff_persondatalayout_ssn;
    BOOLEAN Diff_persondatalayout_linkid;
    BOOLEAN Diff_persondatalayout_ipaddr;
    BOOLEAN Diff_persondatalayout_title;
    BOOLEAN Diff_persondatalayout_fname;
    BOOLEAN Diff_persondatalayout_mname;
    BOOLEAN Diff_persondatalayout_lname;
    BOOLEAN Diff_persondatalayout_name_suffix;
    BOOLEAN Diff_persondatalayout_prim_range;
    BOOLEAN Diff_persondatalayout_predir;
    BOOLEAN Diff_persondatalayout_prim_name;
    BOOLEAN Diff_persondatalayout_addr_suffix;
    BOOLEAN Diff_persondatalayout_postdir;
    BOOLEAN Diff_persondatalayout_unit_desig;
    BOOLEAN Diff_persondatalayout_sec_range;
    BOOLEAN Diff_persondatalayout_v_city_name;
    BOOLEAN Diff_persondatalayout_st;
    BOOLEAN Diff_persondatalayout_zip5;
    BOOLEAN Diff_persondatalayout_zip4;
    BOOLEAN Diff_persondatalayout_addr_rec_type;
    BOOLEAN Diff_persondatalayout_fips_state;
    BOOLEAN Diff_persondatalayout_fips_county;
    BOOLEAN Diff_persondatalayout_geo_lat;
    BOOLEAN Diff_persondatalayout_geo_long;
    BOOLEAN Diff_persondatalayout_cbsa;
    BOOLEAN Diff_persondatalayout_geo_blk;
    BOOLEAN Diff_persondatalayout_geo_match;
    BOOLEAN Diff_persondatalayout_err_stat;
    BOOLEAN Diff_persondatalayout_appended_ssn;
    BOOLEAN Diff_persondatalayout_appended_adl;
    BOOLEAN Diff_permissablelayout_glb_purpose;
    BOOLEAN Diff_permissablelayout_dppa_purpose;
    BOOLEAN Diff_permissablelayout_fcra_purpose;
    BOOLEAN Diff_searchlayout_datetime;
    BOOLEAN Diff_searchlayout_start_monitor;
    BOOLEAN Diff_searchlayout_stop_monitor;
    BOOLEAN Diff_searchlayout_login_history_id;
    BOOLEAN Diff_searchlayout_transaction_id;
    BOOLEAN Diff_searchlayout_sequence_number;
    BOOLEAN Diff_searchlayout_method;
    BOOLEAN Diff_searchlayout_product_code;
    BOOLEAN Diff_searchlayout_transaction_type;
    BOOLEAN Diff_searchlayout_function_description;
    BOOLEAN Diff_searchlayout_ipaddr;
    BOOLEAN Diff_fraudpoint_score;
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_mbslayout_company_id := le.mbslayout_company_id <> ri.mbslayout_company_id;
    SELF.Diff_mbslayout_global_company_id := le.mbslayout_global_company_id <> ri.mbslayout_global_company_id;
    SELF.Diff_allowlayout_allowflags := le.allowlayout_allowflags <> ri.allowlayout_allowflags;
    SELF.Diff_businfolayout_primary_market_code := le.businfolayout_primary_market_code <> ri.businfolayout_primary_market_code;
    SELF.Diff_businfolayout_secondary_market_code := le.businfolayout_secondary_market_code <> ri.businfolayout_secondary_market_code;
    SELF.Diff_businfolayout_industry_1_code := le.businfolayout_industry_1_code <> ri.businfolayout_industry_1_code;
    SELF.Diff_businfolayout_industry_2_code := le.businfolayout_industry_2_code <> ri.businfolayout_industry_2_code;
    SELF.Diff_businfolayout_sub_market := le.businfolayout_sub_market <> ri.businfolayout_sub_market;
    SELF.Diff_businfolayout_vertical := le.businfolayout_vertical <> ri.businfolayout_vertical;
    SELF.Diff_businfolayout_use := le.businfolayout_use <> ri.businfolayout_use;
    SELF.Diff_businfolayout_industry := le.businfolayout_industry <> ri.businfolayout_industry;
    SELF.Diff_persondatalayout_full_name := le.persondatalayout_full_name <> ri.persondatalayout_full_name;
    SELF.Diff_persondatalayout_first_name := le.persondatalayout_first_name <> ri.persondatalayout_first_name;
    SELF.Diff_persondatalayout_middle_name := le.persondatalayout_middle_name <> ri.persondatalayout_middle_name;
    SELF.Diff_persondatalayout_last_name := le.persondatalayout_last_name <> ri.persondatalayout_last_name;
    SELF.Diff_persondatalayout_address := le.persondatalayout_address <> ri.persondatalayout_address;
    SELF.Diff_persondatalayout_city := le.persondatalayout_city <> ri.persondatalayout_city;
    SELF.Diff_persondatalayout_state := le.persondatalayout_state <> ri.persondatalayout_state;
    SELF.Diff_persondatalayout_zip := le.persondatalayout_zip <> ri.persondatalayout_zip;
    SELF.Diff_persondatalayout_personal_phone := le.persondatalayout_personal_phone <> ri.persondatalayout_personal_phone;
    SELF.Diff_persondatalayout_work_phone := le.persondatalayout_work_phone <> ri.persondatalayout_work_phone;
    SELF.Diff_persondatalayout_dob := le.persondatalayout_dob <> ri.persondatalayout_dob;
    SELF.Diff_persondatalayout_dl := le.persondatalayout_dl <> ri.persondatalayout_dl;
    SELF.Diff_persondatalayout_dl_st := le.persondatalayout_dl_st <> ri.persondatalayout_dl_st;
    SELF.Diff_persondatalayout_email_address := le.persondatalayout_email_address <> ri.persondatalayout_email_address;
    SELF.Diff_persondatalayout_ssn := le.persondatalayout_ssn <> ri.persondatalayout_ssn;
    SELF.Diff_persondatalayout_linkid := le.persondatalayout_linkid <> ri.persondatalayout_linkid;
    SELF.Diff_persondatalayout_ipaddr := le.persondatalayout_ipaddr <> ri.persondatalayout_ipaddr;
    SELF.Diff_persondatalayout_title := le.persondatalayout_title <> ri.persondatalayout_title;
    SELF.Diff_persondatalayout_fname := le.persondatalayout_fname <> ri.persondatalayout_fname;
    SELF.Diff_persondatalayout_mname := le.persondatalayout_mname <> ri.persondatalayout_mname;
    SELF.Diff_persondatalayout_lname := le.persondatalayout_lname <> ri.persondatalayout_lname;
    SELF.Diff_persondatalayout_name_suffix := le.persondatalayout_name_suffix <> ri.persondatalayout_name_suffix;
    SELF.Diff_persondatalayout_prim_range := le.persondatalayout_prim_range <> ri.persondatalayout_prim_range;
    SELF.Diff_persondatalayout_predir := le.persondatalayout_predir <> ri.persondatalayout_predir;
    SELF.Diff_persondatalayout_prim_name := le.persondatalayout_prim_name <> ri.persondatalayout_prim_name;
    SELF.Diff_persondatalayout_addr_suffix := le.persondatalayout_addr_suffix <> ri.persondatalayout_addr_suffix;
    SELF.Diff_persondatalayout_postdir := le.persondatalayout_postdir <> ri.persondatalayout_postdir;
    SELF.Diff_persondatalayout_unit_desig := le.persondatalayout_unit_desig <> ri.persondatalayout_unit_desig;
    SELF.Diff_persondatalayout_sec_range := le.persondatalayout_sec_range <> ri.persondatalayout_sec_range;
    SELF.Diff_persondatalayout_v_city_name := le.persondatalayout_v_city_name <> ri.persondatalayout_v_city_name;
    SELF.Diff_persondatalayout_st := le.persondatalayout_st <> ri.persondatalayout_st;
    SELF.Diff_persondatalayout_zip5 := le.persondatalayout_zip5 <> ri.persondatalayout_zip5;
    SELF.Diff_persondatalayout_zip4 := le.persondatalayout_zip4 <> ri.persondatalayout_zip4;
    SELF.Diff_persondatalayout_addr_rec_type := le.persondatalayout_addr_rec_type <> ri.persondatalayout_addr_rec_type;
    SELF.Diff_persondatalayout_fips_state := le.persondatalayout_fips_state <> ri.persondatalayout_fips_state;
    SELF.Diff_persondatalayout_fips_county := le.persondatalayout_fips_county <> ri.persondatalayout_fips_county;
    SELF.Diff_persondatalayout_geo_lat := le.persondatalayout_geo_lat <> ri.persondatalayout_geo_lat;
    SELF.Diff_persondatalayout_geo_long := le.persondatalayout_geo_long <> ri.persondatalayout_geo_long;
    SELF.Diff_persondatalayout_cbsa := le.persondatalayout_cbsa <> ri.persondatalayout_cbsa;
    SELF.Diff_persondatalayout_geo_blk := le.persondatalayout_geo_blk <> ri.persondatalayout_geo_blk;
    SELF.Diff_persondatalayout_geo_match := le.persondatalayout_geo_match <> ri.persondatalayout_geo_match;
    SELF.Diff_persondatalayout_err_stat := le.persondatalayout_err_stat <> ri.persondatalayout_err_stat;
    SELF.Diff_persondatalayout_appended_ssn := le.persondatalayout_appended_ssn <> ri.persondatalayout_appended_ssn;
    SELF.Diff_persondatalayout_appended_adl := le.persondatalayout_appended_adl <> ri.persondatalayout_appended_adl;
    SELF.Diff_permissablelayout_glb_purpose := le.permissablelayout_glb_purpose <> ri.permissablelayout_glb_purpose;
    SELF.Diff_permissablelayout_dppa_purpose := le.permissablelayout_dppa_purpose <> ri.permissablelayout_dppa_purpose;
    SELF.Diff_permissablelayout_fcra_purpose := le.permissablelayout_fcra_purpose <> ri.permissablelayout_fcra_purpose;
    SELF.Diff_searchlayout_datetime := le.searchlayout_datetime <> ri.searchlayout_datetime;
    SELF.Diff_searchlayout_start_monitor := le.searchlayout_start_monitor <> ri.searchlayout_start_monitor;
    SELF.Diff_searchlayout_stop_monitor := le.searchlayout_stop_monitor <> ri.searchlayout_stop_monitor;
    SELF.Diff_searchlayout_login_history_id := le.searchlayout_login_history_id <> ri.searchlayout_login_history_id;
    SELF.Diff_searchlayout_transaction_id := le.searchlayout_transaction_id <> ri.searchlayout_transaction_id;
    SELF.Diff_searchlayout_sequence_number := le.searchlayout_sequence_number <> ri.searchlayout_sequence_number;
    SELF.Diff_searchlayout_method := le.searchlayout_method <> ri.searchlayout_method;
    SELF.Diff_searchlayout_product_code := le.searchlayout_product_code <> ri.searchlayout_product_code;
    SELF.Diff_searchlayout_transaction_type := le.searchlayout_transaction_type <> ri.searchlayout_transaction_type;
    SELF.Diff_searchlayout_function_description := le.searchlayout_function_description <> ri.searchlayout_function_description;
    SELF.Diff_searchlayout_ipaddr := le.searchlayout_ipaddr <> ri.searchlayout_ipaddr;
    SELF.Diff_fraudpoint_score := le.fraudpoint_score <> ri.fraudpoint_score;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_mbslayout_company_id,1,0)+ IF( SELF.Diff_mbslayout_global_company_id,1,0)+ IF( SELF.Diff_allowlayout_allowflags,1,0)+ IF( SELF.Diff_businfolayout_primary_market_code,1,0)+ IF( SELF.Diff_businfolayout_secondary_market_code,1,0)+ IF( SELF.Diff_businfolayout_industry_1_code,1,0)+ IF( SELF.Diff_businfolayout_industry_2_code,1,0)+ IF( SELF.Diff_businfolayout_sub_market,1,0)+ IF( SELF.Diff_businfolayout_vertical,1,0)+ IF( SELF.Diff_businfolayout_use,1,0)+ IF( SELF.Diff_businfolayout_industry,1,0)+ IF( SELF.Diff_persondatalayout_full_name,1,0)+ IF( SELF.Diff_persondatalayout_first_name,1,0)+ IF( SELF.Diff_persondatalayout_middle_name,1,0)+ IF( SELF.Diff_persondatalayout_last_name,1,0)+ IF( SELF.Diff_persondatalayout_address,1,0)+ IF( SELF.Diff_persondatalayout_city,1,0)+ IF( SELF.Diff_persondatalayout_state,1,0)+ IF( SELF.Diff_persondatalayout_zip,1,0)+ IF( SELF.Diff_persondatalayout_personal_phone,1,0)+ IF( SELF.Diff_persondatalayout_work_phone,1,0)+ IF( SELF.Diff_persondatalayout_dob,1,0)+ IF( SELF.Diff_persondatalayout_dl,1,0)+ IF( SELF.Diff_persondatalayout_dl_st,1,0)+ IF( SELF.Diff_persondatalayout_email_address,1,0)+ IF( SELF.Diff_persondatalayout_ssn,1,0)+ IF( SELF.Diff_persondatalayout_linkid,1,0)+ IF( SELF.Diff_persondatalayout_ipaddr,1,0)+ IF( SELF.Diff_persondatalayout_title,1,0)+ IF( SELF.Diff_persondatalayout_fname,1,0)+ IF( SELF.Diff_persondatalayout_mname,1,0)+ IF( SELF.Diff_persondatalayout_lname,1,0)+ IF( SELF.Diff_persondatalayout_name_suffix,1,0)+ IF( SELF.Diff_persondatalayout_prim_range,1,0)+ IF( SELF.Diff_persondatalayout_predir,1,0)+ IF( SELF.Diff_persondatalayout_prim_name,1,0)+ IF( SELF.Diff_persondatalayout_addr_suffix,1,0)+ IF( SELF.Diff_persondatalayout_postdir,1,0)+ IF( SELF.Diff_persondatalayout_unit_desig,1,0)+ IF( SELF.Diff_persondatalayout_sec_range,1,0)+ IF( SELF.Diff_persondatalayout_v_city_name,1,0)+ IF( SELF.Diff_persondatalayout_st,1,0)+ IF( SELF.Diff_persondatalayout_zip5,1,0)+ IF( SELF.Diff_persondatalayout_zip4,1,0)+ IF( SELF.Diff_persondatalayout_addr_rec_type,1,0)+ IF( SELF.Diff_persondatalayout_fips_state,1,0)+ IF( SELF.Diff_persondatalayout_fips_county,1,0)+ IF( SELF.Diff_persondatalayout_geo_lat,1,0)+ IF( SELF.Diff_persondatalayout_geo_long,1,0)+ IF( SELF.Diff_persondatalayout_cbsa,1,0)+ IF( SELF.Diff_persondatalayout_geo_blk,1,0)+ IF( SELF.Diff_persondatalayout_geo_match,1,0)+ IF( SELF.Diff_persondatalayout_err_stat,1,0)+ IF( SELF.Diff_persondatalayout_appended_ssn,1,0)+ IF( SELF.Diff_persondatalayout_appended_adl,1,0)+ IF( SELF.Diff_permissablelayout_glb_purpose,1,0)+ IF( SELF.Diff_permissablelayout_dppa_purpose,1,0)+ IF( SELF.Diff_permissablelayout_fcra_purpose,1,0)+ IF( SELF.Diff_searchlayout_datetime,1,0)+ IF( SELF.Diff_searchlayout_start_monitor,1,0)+ IF( SELF.Diff_searchlayout_stop_monitor,1,0)+ IF( SELF.Diff_searchlayout_login_history_id,1,0)+ IF( SELF.Diff_searchlayout_transaction_id,1,0)+ IF( SELF.Diff_searchlayout_sequence_number,1,0)+ IF( SELF.Diff_searchlayout_method,1,0)+ IF( SELF.Diff_searchlayout_product_code,1,0)+ IF( SELF.Diff_searchlayout_transaction_type,1,0)+ IF( SELF.Diff_searchlayout_function_description,1,0)+ IF( SELF.Diff_searchlayout_ipaddr,1,0)+ IF( SELF.Diff_fraudpoint_score,1,0);
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
    Count_Diff_mbslayout_company_id := COUNT(GROUP,%Closest%.Diff_mbslayout_company_id);
    Count_Diff_mbslayout_global_company_id := COUNT(GROUP,%Closest%.Diff_mbslayout_global_company_id);
    Count_Diff_allowlayout_allowflags := COUNT(GROUP,%Closest%.Diff_allowlayout_allowflags);
    Count_Diff_businfolayout_primary_market_code := COUNT(GROUP,%Closest%.Diff_businfolayout_primary_market_code);
    Count_Diff_businfolayout_secondary_market_code := COUNT(GROUP,%Closest%.Diff_businfolayout_secondary_market_code);
    Count_Diff_businfolayout_industry_1_code := COUNT(GROUP,%Closest%.Diff_businfolayout_industry_1_code);
    Count_Diff_businfolayout_industry_2_code := COUNT(GROUP,%Closest%.Diff_businfolayout_industry_2_code);
    Count_Diff_businfolayout_sub_market := COUNT(GROUP,%Closest%.Diff_businfolayout_sub_market);
    Count_Diff_businfolayout_vertical := COUNT(GROUP,%Closest%.Diff_businfolayout_vertical);
    Count_Diff_businfolayout_use := COUNT(GROUP,%Closest%.Diff_businfolayout_use);
    Count_Diff_businfolayout_industry := COUNT(GROUP,%Closest%.Diff_businfolayout_industry);
    Count_Diff_persondatalayout_full_name := COUNT(GROUP,%Closest%.Diff_persondatalayout_full_name);
    Count_Diff_persondatalayout_first_name := COUNT(GROUP,%Closest%.Diff_persondatalayout_first_name);
    Count_Diff_persondatalayout_middle_name := COUNT(GROUP,%Closest%.Diff_persondatalayout_middle_name);
    Count_Diff_persondatalayout_last_name := COUNT(GROUP,%Closest%.Diff_persondatalayout_last_name);
    Count_Diff_persondatalayout_address := COUNT(GROUP,%Closest%.Diff_persondatalayout_address);
    Count_Diff_persondatalayout_city := COUNT(GROUP,%Closest%.Diff_persondatalayout_city);
    Count_Diff_persondatalayout_state := COUNT(GROUP,%Closest%.Diff_persondatalayout_state);
    Count_Diff_persondatalayout_zip := COUNT(GROUP,%Closest%.Diff_persondatalayout_zip);
    Count_Diff_persondatalayout_personal_phone := COUNT(GROUP,%Closest%.Diff_persondatalayout_personal_phone);
    Count_Diff_persondatalayout_work_phone := COUNT(GROUP,%Closest%.Diff_persondatalayout_work_phone);
    Count_Diff_persondatalayout_dob := COUNT(GROUP,%Closest%.Diff_persondatalayout_dob);
    Count_Diff_persondatalayout_dl := COUNT(GROUP,%Closest%.Diff_persondatalayout_dl);
    Count_Diff_persondatalayout_dl_st := COUNT(GROUP,%Closest%.Diff_persondatalayout_dl_st);
    Count_Diff_persondatalayout_email_address := COUNT(GROUP,%Closest%.Diff_persondatalayout_email_address);
    Count_Diff_persondatalayout_ssn := COUNT(GROUP,%Closest%.Diff_persondatalayout_ssn);
    Count_Diff_persondatalayout_linkid := COUNT(GROUP,%Closest%.Diff_persondatalayout_linkid);
    Count_Diff_persondatalayout_ipaddr := COUNT(GROUP,%Closest%.Diff_persondatalayout_ipaddr);
    Count_Diff_persondatalayout_title := COUNT(GROUP,%Closest%.Diff_persondatalayout_title);
    Count_Diff_persondatalayout_fname := COUNT(GROUP,%Closest%.Diff_persondatalayout_fname);
    Count_Diff_persondatalayout_mname := COUNT(GROUP,%Closest%.Diff_persondatalayout_mname);
    Count_Diff_persondatalayout_lname := COUNT(GROUP,%Closest%.Diff_persondatalayout_lname);
    Count_Diff_persondatalayout_name_suffix := COUNT(GROUP,%Closest%.Diff_persondatalayout_name_suffix);
    Count_Diff_persondatalayout_prim_range := COUNT(GROUP,%Closest%.Diff_persondatalayout_prim_range);
    Count_Diff_persondatalayout_predir := COUNT(GROUP,%Closest%.Diff_persondatalayout_predir);
    Count_Diff_persondatalayout_prim_name := COUNT(GROUP,%Closest%.Diff_persondatalayout_prim_name);
    Count_Diff_persondatalayout_addr_suffix := COUNT(GROUP,%Closest%.Diff_persondatalayout_addr_suffix);
    Count_Diff_persondatalayout_postdir := COUNT(GROUP,%Closest%.Diff_persondatalayout_postdir);
    Count_Diff_persondatalayout_unit_desig := COUNT(GROUP,%Closest%.Diff_persondatalayout_unit_desig);
    Count_Diff_persondatalayout_sec_range := COUNT(GROUP,%Closest%.Diff_persondatalayout_sec_range);
    Count_Diff_persondatalayout_v_city_name := COUNT(GROUP,%Closest%.Diff_persondatalayout_v_city_name);
    Count_Diff_persondatalayout_st := COUNT(GROUP,%Closest%.Diff_persondatalayout_st);
    Count_Diff_persondatalayout_zip5 := COUNT(GROUP,%Closest%.Diff_persondatalayout_zip5);
    Count_Diff_persondatalayout_zip4 := COUNT(GROUP,%Closest%.Diff_persondatalayout_zip4);
    Count_Diff_persondatalayout_addr_rec_type := COUNT(GROUP,%Closest%.Diff_persondatalayout_addr_rec_type);
    Count_Diff_persondatalayout_fips_state := COUNT(GROUP,%Closest%.Diff_persondatalayout_fips_state);
    Count_Diff_persondatalayout_fips_county := COUNT(GROUP,%Closest%.Diff_persondatalayout_fips_county);
    Count_Diff_persondatalayout_geo_lat := COUNT(GROUP,%Closest%.Diff_persondatalayout_geo_lat);
    Count_Diff_persondatalayout_geo_long := COUNT(GROUP,%Closest%.Diff_persondatalayout_geo_long);
    Count_Diff_persondatalayout_cbsa := COUNT(GROUP,%Closest%.Diff_persondatalayout_cbsa);
    Count_Diff_persondatalayout_geo_blk := COUNT(GROUP,%Closest%.Diff_persondatalayout_geo_blk);
    Count_Diff_persondatalayout_geo_match := COUNT(GROUP,%Closest%.Diff_persondatalayout_geo_match);
    Count_Diff_persondatalayout_err_stat := COUNT(GROUP,%Closest%.Diff_persondatalayout_err_stat);
    Count_Diff_persondatalayout_appended_ssn := COUNT(GROUP,%Closest%.Diff_persondatalayout_appended_ssn);
    Count_Diff_persondatalayout_appended_adl := COUNT(GROUP,%Closest%.Diff_persondatalayout_appended_adl);
    Count_Diff_permissablelayout_glb_purpose := COUNT(GROUP,%Closest%.Diff_permissablelayout_glb_purpose);
    Count_Diff_permissablelayout_dppa_purpose := COUNT(GROUP,%Closest%.Diff_permissablelayout_dppa_purpose);
    Count_Diff_permissablelayout_fcra_purpose := COUNT(GROUP,%Closest%.Diff_permissablelayout_fcra_purpose);
    Count_Diff_searchlayout_datetime := COUNT(GROUP,%Closest%.Diff_searchlayout_datetime);
    Count_Diff_searchlayout_start_monitor := COUNT(GROUP,%Closest%.Diff_searchlayout_start_monitor);
    Count_Diff_searchlayout_stop_monitor := COUNT(GROUP,%Closest%.Diff_searchlayout_stop_monitor);
    Count_Diff_searchlayout_login_history_id := COUNT(GROUP,%Closest%.Diff_searchlayout_login_history_id);
    Count_Diff_searchlayout_transaction_id := COUNT(GROUP,%Closest%.Diff_searchlayout_transaction_id);
    Count_Diff_searchlayout_sequence_number := COUNT(GROUP,%Closest%.Diff_searchlayout_sequence_number);
    Count_Diff_searchlayout_method := COUNT(GROUP,%Closest%.Diff_searchlayout_method);
    Count_Diff_searchlayout_product_code := COUNT(GROUP,%Closest%.Diff_searchlayout_product_code);
    Count_Diff_searchlayout_transaction_type := COUNT(GROUP,%Closest%.Diff_searchlayout_transaction_type);
    Count_Diff_searchlayout_function_description := COUNT(GROUP,%Closest%.Diff_searchlayout_function_description);
    Count_Diff_searchlayout_ipaddr := COUNT(GROUP,%Closest%.Diff_searchlayout_ipaddr);
    Count_Diff_fraudpoint_score := COUNT(GROUP,%Closest%.Diff_fraudpoint_score);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
