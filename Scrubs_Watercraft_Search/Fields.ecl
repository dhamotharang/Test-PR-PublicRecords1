IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 95;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_name','invalid_company','invalid_numeric','invalid_address','invalid_state','invalid_zip','invalid_date','invalid_dppa_flag','invalid_history_flag','invalid_owner_type','invalid_fips','invalid_ssn_fein','invalid_phone','invalid_blank','invalid_source_code');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_name' => 2,'invalid_company' => 3,'invalid_numeric' => 4,'invalid_address' => 5,'invalid_state' => 6,'invalid_zip' => 7,'invalid_date' => 8,'invalid_dppa_flag' => 9,'invalid_history_flag' => 10,'invalid_owner_type' => 11,'invalid_fips' => 12,'invalid_ssn_fein' => 13,'invalid_phone' => 14,'invalid_blank' => 15,'invalid_source_code' => 16,0);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,&\\/.:;_'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -,&\\/.:;_',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,&\\/.:;_'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,&\\/.:;_'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,&\\/.:#;()"'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -,&\\/.:#;()"',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_company(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,&\\/.:#;()"'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_company(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,&\\/.:#;()"'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -&/\\#.;,'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -&/\\#.;,',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_address(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -&/\\#.;,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -&/\\#.;,'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('2,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789X -'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789X -'))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789X -'),SALT311.HygieneErrors.NotLength('10,9,6,5,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789?'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,'?',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789?'))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789?'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dppa_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dppa_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N'],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_dppa_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N'),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_history_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_history_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['H','U','E',' '],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_history_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('H|U|E| '),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_owner_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_owner_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['O','R','B',' '],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_owner_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('O|R|B| '),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_fips(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_fips(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ssn_fein(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ssn_fein(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_ssn_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('9,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('10,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_blank(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ[]'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_source_code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ[]'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ[]'),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','watercraft_key','sequence_key','state_origin','source_code','dppa_flag','orig_name','orig_name_type_code','orig_name_type_description','orig_name_first','orig_name_middle','orig_name_last','orig_name_suffix','orig_address_1','orig_address_2','orig_city','orig_state','orig_zip','orig_fips','orig_province','orig_country','dob','orig_ssn','orig_fein','gender','phone_1','phone_2','title','fname','mname','lname','name_suffix','name_cleaning_score','company_name','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','county','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','bdid','fein','did','did_score','ssn','history_flag','rawaid','reg_owner_name_2','persistent_record_id','source_rec_id','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','watercraft_key','sequence_key','state_origin','source_code','dppa_flag','orig_name','orig_name_type_code','orig_name_type_description','orig_name_first','orig_name_middle','orig_name_last','orig_name_suffix','orig_address_1','orig_address_2','orig_city','orig_state','orig_zip','orig_fips','orig_province','orig_country','dob','orig_ssn','orig_fein','gender','phone_1','phone_2','title','fname','mname','lname','name_suffix','name_cleaning_score','company_name','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','county','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','bdid','fein','did','did_score','ssn','history_flag','rawaid','reg_owner_name_2','persistent_record_id','source_rec_id','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'date_first_seen' => 0,'date_last_seen' => 1,'date_vendor_first_reported' => 2,'date_vendor_last_reported' => 3,'watercraft_key' => 4,'sequence_key' => 5,'state_origin' => 6,'source_code' => 7,'dppa_flag' => 8,'orig_name' => 9,'orig_name_type_code' => 10,'orig_name_type_description' => 11,'orig_name_first' => 12,'orig_name_middle' => 13,'orig_name_last' => 14,'orig_name_suffix' => 15,'orig_address_1' => 16,'orig_address_2' => 17,'orig_city' => 18,'orig_state' => 19,'orig_zip' => 20,'orig_fips' => 21,'orig_province' => 22,'orig_country' => 23,'dob' => 24,'orig_ssn' => 25,'orig_fein' => 26,'gender' => 27,'phone_1' => 28,'phone_2' => 29,'title' => 30,'fname' => 31,'mname' => 32,'lname' => 33,'name_suffix' => 34,'name_cleaning_score' => 35,'company_name' => 36,'prim_range' => 37,'predir' => 38,'prim_name' => 39,'suffix' => 40,'postdir' => 41,'unit_desig' => 42,'sec_range' => 43,'p_city_name' => 44,'v_city_name' => 45,'st' => 46,'zip5' => 47,'zip4' => 48,'county' => 49,'cart' => 50,'cr_sort_sz' => 51,'lot' => 52,'lot_order' => 53,'dpbc' => 54,'chk_digit' => 55,'rec_type' => 56,'ace_fips_st' => 57,'ace_fips_county' => 58,'geo_lat' => 59,'geo_long' => 60,'msa' => 61,'geo_blk' => 62,'geo_match' => 63,'err_stat' => 64,'bdid' => 65,'fein' => 66,'did' => 67,'did_score' => 68,'ssn' => 69,'history_flag' => 70,'rawaid' => 71,'reg_owner_name_2' => 72,'persistent_record_id' => 73,'source_rec_id' => 74,'dotscore' => 75,'dotweight' => 76,'empid' => 77,'empscore' => 78,'empweight' => 79,'powid' => 80,'powscore' => 81,'powweight' => 82,'proxid' => 83,'proxscore' => 84,'proxweight' => 85,'seleid' => 86,'selescore' => 87,'seleweight' => 88,'orgid' => 89,'orgscore' => 90,'orgweight' => 91,'ultid' => 92,'ultscore' => 93,'ultweight' => 94,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LENGTHS'],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],[],['ENUM','LENGTHS'],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW'],[],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],[],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],[],[],[],[],['ALLOW','LENGTHS'],[],[],[],[],[],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_date_first_seen(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_first_seen(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_date_last_seen(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_last_seen(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_date_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_date_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_watercraft_key(SALT311.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_watercraft_key(SALT311.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_watercraft_key(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
 
EXPORT Make_sequence_key(SALT311.StrType s0) := s0;
EXPORT InValid_sequence_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_sequence_key(UNSIGNED1 wh) := '';
 
EXPORT Make_state_origin(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state_origin(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_source_code(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_source_code(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_source_code(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_dppa_flag(SALT311.StrType s0) := MakeFT_invalid_dppa_flag(s0);
EXPORT InValid_dppa_flag(SALT311.StrType s) := InValidFT_invalid_dppa_flag(s);
EXPORT InValidMessage_dppa_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_dppa_flag(wh);
 
EXPORT Make_orig_name(SALT311.StrType s0) := s0;
EXPORT InValid_orig_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_name(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_name_type_code(SALT311.StrType s0) := MakeFT_invalid_owner_type(s0);
EXPORT InValid_orig_name_type_code(SALT311.StrType s) := InValidFT_invalid_owner_type(s);
EXPORT InValidMessage_orig_name_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_owner_type(wh);
 
EXPORT Make_orig_name_type_description(SALT311.StrType s0) := s0;
EXPORT InValid_orig_name_type_description(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_name_type_description(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_name_first(SALT311.StrType s0) := s0;
EXPORT InValid_orig_name_first(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_name_first(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_name_middle(SALT311.StrType s0) := s0;
EXPORT InValid_orig_name_middle(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_name_middle(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_name_last(SALT311.StrType s0) := s0;
EXPORT InValid_orig_name_last(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_name_last(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_orig_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_address_1(SALT311.StrType s0) := s0;
EXPORT InValid_orig_address_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_address_1(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_address_2(SALT311.StrType s0) := s0;
EXPORT InValid_orig_address_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_address_2(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_city(SALT311.StrType s0) := s0;
EXPORT InValid_orig_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_state(SALT311.StrType s0) := s0;
EXPORT InValid_orig_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_zip(SALT311.StrType s0) := s0;
EXPORT InValid_orig_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_fips(SALT311.StrType s0) := s0;
EXPORT InValid_orig_fips(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_fips(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_province(SALT311.StrType s0) := s0;
EXPORT InValid_orig_province(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_province(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_country(SALT311.StrType s0) := s0;
EXPORT InValid_orig_country(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_country(UNSIGNED1 wh) := '';
 
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_orig_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_orig_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_fein(SALT311.StrType s0) := s0;
EXPORT InValid_orig_fein(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_gender(SALT311.StrType s0) := s0;
EXPORT InValid_gender(SALT311.StrType s) := 0;
EXPORT InValidMessage_gender(UNSIGNED1 wh) := '';
 
EXPORT Make_phone_1(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone_1(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone_1(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_phone_2(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone_2(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone_2(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_title(SALT311.StrType s0) := s0;
EXPORT InValid_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_mname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_name_suffix(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_suffix(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_name_cleaning_score(SALT311.StrType s0) := s0;
EXPORT InValid_name_cleaning_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_cleaning_score(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_invalid_company(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_invalid_company(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_company(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_suffix(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_suffix(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip5(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_zip5(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_county(SALT311.StrType s0) := s0;
EXPORT InValid_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT311.StrType s0) := s0;
EXPORT InValid_cart(SALT311.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT311.StrType s0) := s0;
EXPORT InValid_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT311.StrType s0) := s0;
EXPORT InValid_lot_order(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dpbc(SALT311.StrType s0) := s0;
EXPORT InValid_dpbc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT311.StrType s0) := MakeFT_invalid_fips(s0);
EXPORT InValid_ace_fips_st(SALT311.StrType s) := InValidFT_invalid_fips(s);
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_fips(wh);
 
EXPORT Make_ace_fips_county(SALT311.StrType s0) := s0;
EXPORT InValid_ace_fips_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_fips_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT311.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT311.StrType s0) := s0;
EXPORT InValid_geo_long(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT311.StrType s0) := s0;
EXPORT InValid_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT311.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT311.StrType s0) := s0;
EXPORT InValid_geo_match(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_fein(SALT311.StrType s0) := MakeFT_invalid_ssn_fein(s0);
EXPORT InValid_fein(SALT311.StrType s) := InValidFT_invalid_ssn_fein(s);
EXPORT InValidMessage_fein(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn_fein(wh);
 
EXPORT Make_did(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_did_score(SALT311.StrType s0) := s0;
EXPORT InValid_did_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_ssn(SALT311.StrType s0) := MakeFT_invalid_ssn_fein(s0);
EXPORT InValid_ssn(SALT311.StrType s) := InValidFT_invalid_ssn_fein(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn_fein(wh);
 
EXPORT Make_history_flag(SALT311.StrType s0) := MakeFT_invalid_history_flag(s0);
EXPORT InValid_history_flag(SALT311.StrType s) := InValidFT_invalid_history_flag(s);
EXPORT InValidMessage_history_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_history_flag(wh);
 
EXPORT Make_rawaid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_rawaid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_reg_owner_name_2(SALT311.StrType s0) := s0;
EXPORT InValid_reg_owner_name_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_reg_owner_name_2(UNSIGNED1 wh) := '';
 
EXPORT Make_persistent_record_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_persistent_record_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_source_rec_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_source_rec_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_dotscore(SALT311.StrType s0) := s0;
EXPORT InValid_dotscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT311.StrType s0) := s0;
EXPORT InValid_dotweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT311.StrType s0) := s0;
EXPORT InValid_empid(SALT311.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT311.StrType s0) := s0;
EXPORT InValid_empscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT311.StrType s0) := s0;
EXPORT InValid_empweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT311.StrType s0) := s0;
EXPORT InValid_powid(SALT311.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT311.StrType s0) := s0;
EXPORT InValid_powscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT311.StrType s0) := s0;
EXPORT InValid_powweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT311.StrType s0) := s0;
EXPORT InValid_proxid(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT311.StrType s0) := s0;
EXPORT InValid_proxscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT311.StrType s0) := s0;
EXPORT InValid_proxweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT311.StrType s0) := s0;
EXPORT InValid_seleid(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT311.StrType s0) := s0;
EXPORT InValid_selescore(SALT311.StrType s) := 0;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT311.StrType s0) := s0;
EXPORT InValid_seleweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT311.StrType s0) := s0;
EXPORT InValid_orgid(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT311.StrType s0) := s0;
EXPORT InValid_orgscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT311.StrType s0) := s0;
EXPORT InValid_orgweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT311.StrType s0) := s0;
EXPORT InValid_ultid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT311.StrType s0) := s0;
EXPORT InValid_ultscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT311.StrType s0) := s0;
EXPORT InValid_ultweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Watercraft_Search;
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
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_watercraft_key;
    BOOLEAN Diff_sequence_key;
    BOOLEAN Diff_state_origin;
    BOOLEAN Diff_source_code;
    BOOLEAN Diff_dppa_flag;
    BOOLEAN Diff_orig_name;
    BOOLEAN Diff_orig_name_type_code;
    BOOLEAN Diff_orig_name_type_description;
    BOOLEAN Diff_orig_name_first;
    BOOLEAN Diff_orig_name_middle;
    BOOLEAN Diff_orig_name_last;
    BOOLEAN Diff_orig_name_suffix;
    BOOLEAN Diff_orig_address_1;
    BOOLEAN Diff_orig_address_2;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_fips;
    BOOLEAN Diff_orig_province;
    BOOLEAN Diff_orig_country;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_orig_ssn;
    BOOLEAN Diff_orig_fein;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_phone_1;
    BOOLEAN Diff_phone_2;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_cleaning_score;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_county;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_ace_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_fein;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_history_flag;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_reg_owner_name_2;
    BOOLEAN Diff_persistent_record_id;
    BOOLEAN Diff_source_rec_id;
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
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_watercraft_key := le.watercraft_key <> ri.watercraft_key;
    SELF.Diff_sequence_key := le.sequence_key <> ri.sequence_key;
    SELF.Diff_state_origin := le.state_origin <> ri.state_origin;
    SELF.Diff_source_code := le.source_code <> ri.source_code;
    SELF.Diff_dppa_flag := le.dppa_flag <> ri.dppa_flag;
    SELF.Diff_orig_name := le.orig_name <> ri.orig_name;
    SELF.Diff_orig_name_type_code := le.orig_name_type_code <> ri.orig_name_type_code;
    SELF.Diff_orig_name_type_description := le.orig_name_type_description <> ri.orig_name_type_description;
    SELF.Diff_orig_name_first := le.orig_name_first <> ri.orig_name_first;
    SELF.Diff_orig_name_middle := le.orig_name_middle <> ri.orig_name_middle;
    SELF.Diff_orig_name_last := le.orig_name_last <> ri.orig_name_last;
    SELF.Diff_orig_name_suffix := le.orig_name_suffix <> ri.orig_name_suffix;
    SELF.Diff_orig_address_1 := le.orig_address_1 <> ri.orig_address_1;
    SELF.Diff_orig_address_2 := le.orig_address_2 <> ri.orig_address_2;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_fips := le.orig_fips <> ri.orig_fips;
    SELF.Diff_orig_province := le.orig_province <> ri.orig_province;
    SELF.Diff_orig_country := le.orig_country <> ri.orig_country;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_orig_ssn := le.orig_ssn <> ri.orig_ssn;
    SELF.Diff_orig_fein := le.orig_fein <> ri.orig_fein;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_phone_1 := le.phone_1 <> ri.phone_1;
    SELF.Diff_phone_2 := le.phone_2 <> ri.phone_2;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_cleaning_score := le.name_cleaning_score <> ri.name_cleaning_score;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_ace_fips_county := le.ace_fips_county <> ri.ace_fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_fein := le.fein <> ri.fein;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_history_flag := le.history_flag <> ri.history_flag;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_reg_owner_name_2 := le.reg_owner_name_2 <> ri.reg_owner_name_2;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
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
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source_code;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_watercraft_key,1,0)+ IF( SELF.Diff_sequence_key,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_dppa_flag,1,0)+ IF( SELF.Diff_orig_name,1,0)+ IF( SELF.Diff_orig_name_type_code,1,0)+ IF( SELF.Diff_orig_name_type_description,1,0)+ IF( SELF.Diff_orig_name_first,1,0)+ IF( SELF.Diff_orig_name_middle,1,0)+ IF( SELF.Diff_orig_name_last,1,0)+ IF( SELF.Diff_orig_name_suffix,1,0)+ IF( SELF.Diff_orig_address_1,1,0)+ IF( SELF.Diff_orig_address_2,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_fips,1,0)+ IF( SELF.Diff_orig_province,1,0)+ IF( SELF.Diff_orig_country,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_orig_fein,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_phone_1,1,0)+ IF( SELF.Diff_phone_2,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_cleaning_score,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_ace_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_fein,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_history_flag,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_reg_owner_name_2,1,0)+ IF( SELF.Diff_persistent_record_id,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0);
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
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_watercraft_key := COUNT(GROUP,%Closest%.Diff_watercraft_key);
    Count_Diff_sequence_key := COUNT(GROUP,%Closest%.Diff_sequence_key);
    Count_Diff_state_origin := COUNT(GROUP,%Closest%.Diff_state_origin);
    Count_Diff_source_code := COUNT(GROUP,%Closest%.Diff_source_code);
    Count_Diff_dppa_flag := COUNT(GROUP,%Closest%.Diff_dppa_flag);
    Count_Diff_orig_name := COUNT(GROUP,%Closest%.Diff_orig_name);
    Count_Diff_orig_name_type_code := COUNT(GROUP,%Closest%.Diff_orig_name_type_code);
    Count_Diff_orig_name_type_description := COUNT(GROUP,%Closest%.Diff_orig_name_type_description);
    Count_Diff_orig_name_first := COUNT(GROUP,%Closest%.Diff_orig_name_first);
    Count_Diff_orig_name_middle := COUNT(GROUP,%Closest%.Diff_orig_name_middle);
    Count_Diff_orig_name_last := COUNT(GROUP,%Closest%.Diff_orig_name_last);
    Count_Diff_orig_name_suffix := COUNT(GROUP,%Closest%.Diff_orig_name_suffix);
    Count_Diff_orig_address_1 := COUNT(GROUP,%Closest%.Diff_orig_address_1);
    Count_Diff_orig_address_2 := COUNT(GROUP,%Closest%.Diff_orig_address_2);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_fips := COUNT(GROUP,%Closest%.Diff_orig_fips);
    Count_Diff_orig_province := COUNT(GROUP,%Closest%.Diff_orig_province);
    Count_Diff_orig_country := COUNT(GROUP,%Closest%.Diff_orig_country);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_orig_ssn := COUNT(GROUP,%Closest%.Diff_orig_ssn);
    Count_Diff_orig_fein := COUNT(GROUP,%Closest%.Diff_orig_fein);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_phone_1 := COUNT(GROUP,%Closest%.Diff_phone_1);
    Count_Diff_phone_2 := COUNT(GROUP,%Closest%.Diff_phone_2);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_cleaning_score := COUNT(GROUP,%Closest%.Diff_name_cleaning_score);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_ace_fips_county := COUNT(GROUP,%Closest%.Diff_ace_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_fein := COUNT(GROUP,%Closest%.Diff_fein);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_history_flag := COUNT(GROUP,%Closest%.Diff_history_flag);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_reg_owner_name_2 := COUNT(GROUP,%Closest%.Diff_reg_owner_name_2);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
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
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
