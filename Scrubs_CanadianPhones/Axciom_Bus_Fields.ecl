IMPORT ut,SALT32;
EXPORT Axciom_Bus_Fields := MODULE
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_record_id','invalid_date','invalid_area_code','invalid_phone','invalid_numeric','invalid_alpha','invalid_alnum','invalid_address','invalid_city','invalid_name','invalid_canadian_zip','invalid_province','invalid_lat_long_level_applied','invalid_record_use_indicator','invalid_bus_govt_indicator','invalid_email','invalid_verification_flag');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'invalid_record_id' => 1,'invalid_date' => 2,'invalid_area_code' => 3,'invalid_phone' => 4,'invalid_numeric' => 5,'invalid_alpha' => 6,'invalid_alnum' => 7,'invalid_address' => 8,'invalid_city' => 9,'invalid_name' => 10,'invalid_canadian_zip' => 11,'invalid_province' => 12,'invalid_lat_long_level_applied' => 13,'invalid_record_use_indicator' => 14,'invalid_bus_govt_indicator' => 15,'invalid_email' => 16,'invalid_verification_flag' => 17,0);
EXPORT MakeFT_invalid_record_id(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_record_id(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_record_id(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT32.HygieneErrors.NotLength('10,0'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.NotLength('6,0'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_area_code(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_area_code(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_area_code(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.NotLength('3,0'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_phone(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.NotLength('7,0'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_numeric(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789.-+,'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789.-+,'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789.-+,'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_alpha(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ‚ÃƒÃÃ…Ã„Ã‘ÃšÃœÃÃÃŽÃ”Ã–Ã“??Ã˜Ã‹ÃˆÃ‰Ã¢Ã£Ã¡Ã¥Ã¤Ã¯Ã¶Ã¸Ã©Ã¼?? -\'/.'); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' -\'/.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ‚ÃƒÃÃ…Ã„Ã‘ÃšÃœÃÃÃŽÃ”Ã–Ã“??Ã˜Ã‹ÃˆÃ‰Ã¢Ã£Ã¡Ã¥Ã¤Ã¯Ã¶Ã¸Ã©Ã¼?? -\'/.'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ‚ÃƒÃÃ…Ã„Ã‘ÃšÃœÃÃÃŽÃ”Ã–Ã“??Ã˜Ã‹ÃˆÃ‰Ã¢Ã£Ã¡Ã¥Ã¤Ã¯Ã¶Ã¸Ã©Ã¼?? -\'/.'),SALT32.HygieneErrors.NotLength('0..'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_alnum(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -/'); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' -/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alnum(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -/'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alnum(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -/'),SALT32.HygieneErrors.NotLength('0..'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_address(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ‚ÃƒÃÃ…Ã„Ã‘ÃšÃœÃÃÃŽÃ”Ã–Ã“Ã¸Ã˜Ã‹ÃˆÃ‰Ã¤Ã¯Ã¶Ã©Ã¼?0123456789\'@+~$| ()-&/\\#.;,\\:"=*'); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ()-&/\\#.;,\\:"=*',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ‚ÃƒÃÃ…Ã„Ã‘ÃšÃœÃÃÃŽÃ”Ã–Ã“Ã¸Ã˜Ã‹ÃˆÃ‰Ã¤Ã¯Ã¶Ã©Ã¼?0123456789\'@+~$| ()-&/\\#.;,\\:"=*'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ‚ÃƒÃÃ…Ã„Ã‘ÃšÃœÃÃÃŽÃ”Ã–Ã“Ã¸Ã˜Ã‹ÃˆÃ‰Ã¤Ã¯Ã¶Ã©Ã¼?0123456789\'@+~$| ()-&/\\#.;,\\:"=*'),SALT32.HygieneErrors.NotLength('0..'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_city(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\'().,?& ;\\:'); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ;\\:',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_city(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\'().,?& ;\\:'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\'().,?& ;\\:'),SALT32.HygieneErrors.NotLength('0..'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©0123456789\'"+=@#$%^&+-_\\:*!? ,.(){}/\\;'); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ,.(){}/\\;',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©0123456789\'"+=@#$%^&+-_\\:*!? ,.(){}/\\;'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©0123456789\'"+=@#$%^&+-_\\:*!? ,.(){}/\\;'),SALT32.HygieneErrors.NotLength('0..'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_canadian_zip(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_canadian_zip(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 3));
EXPORT InValidMessageFT_invalid_canadian_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '),SALT32.HygieneErrors.NotLength('0,3..'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_province(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_province(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_province(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT32.HygieneErrors.NotLength('2,0'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_lat_long_level_applied(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_lat_long_level_applied(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_lat_long_level_applied(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT32.HygieneErrors.NotLength('2,0'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_record_use_indicator(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_use_indicator(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['B','C','M','T',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_record_use_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('B|C|M|T|'),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_bus_govt_indicator(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bus_govt_indicator(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['1','5','6','A','B','C','D','E','F','G','H','I',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_bus_govt_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('1|5|6|A|B|C|D|E|F|G|H|I|'),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_email(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@\\:.-_ ,&!?/;|\''); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ,&!?/;|\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_email(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@\\:.-_ ,&!?/;|\''))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@\\:.-_ ,&!?/;|\''),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_verification_flag(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_verification_flag(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['0','1','2','3',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_verification_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('0|1|2|3|'),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.Good);
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'record_id','book_number','pub_date','business_name','street_number','street_name','unit_designator','unit_number','city','province','postal_code','area_code','phone_number','syph_1','syph_2','syph_3','syph_4','syph_5','syph_6','naics_1','naics_2','naics_3','naics_4','naics_5','naics_6','bdc_1','bdc_2','bdc_3','bdc_4','bdc_5','bdc_6','sic_1','sic_2','sic_3','sic_4','sic_5','sic_6','caption_counter','caption_1','caption_2','caption_3','caption_4','caption_5','caption_6','vanity_city','bus_govt_indicator','latitude','longitude','lat_long_level_applied','record_use_indicator','email','stated_addr','stated_city','stated_postal_code','stated_bus_name','verification_flag');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'record_id' => 0,'book_number' => 1,'pub_date' => 2,'business_name' => 3,'street_number' => 4,'street_name' => 5,'unit_designator' => 6,'unit_number' => 7,'city' => 8,'province' => 9,'postal_code' => 10,'area_code' => 11,'phone_number' => 12,'syph_1' => 13,'syph_2' => 14,'syph_3' => 15,'syph_4' => 16,'syph_5' => 17,'syph_6' => 18,'naics_1' => 19,'naics_2' => 20,'naics_3' => 21,'naics_4' => 22,'naics_5' => 23,'naics_6' => 24,'bdc_1' => 25,'bdc_2' => 26,'bdc_3' => 27,'bdc_4' => 28,'bdc_5' => 29,'bdc_6' => 30,'sic_1' => 31,'sic_2' => 32,'sic_3' => 33,'sic_4' => 34,'sic_5' => 35,'sic_6' => 36,'caption_counter' => 37,'caption_1' => 38,'caption_2' => 39,'caption_3' => 40,'caption_4' => 41,'caption_5' => 42,'caption_6' => 43,'vanity_city' => 44,'bus_govt_indicator' => 45,'latitude' => 46,'longitude' => 47,'lat_long_level_applied' => 48,'record_use_indicator' => 49,'email' => 50,'stated_addr' => 51,'stated_city' => 52,'stated_postal_code' => 53,'stated_bus_name' => 54,'verification_flag' => 55,0);
//Individual field level validation
EXPORT Make_record_id(SALT32.StrType s0) := MakeFT_invalid_record_id(s0);
EXPORT InValid_record_id(SALT32.StrType s) := InValidFT_invalid_record_id(s);
EXPORT InValidMessage_record_id(UNSIGNED1 wh) := InValidMessageFT_invalid_record_id(wh);
EXPORT Make_book_number(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_book_number(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_book_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_pub_date(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_pub_date(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_pub_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_business_name(SALT32.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_business_name(SALT32.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_street_number(SALT32.StrType s0) := s0;
EXPORT InValid_street_number(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_street_number(UNSIGNED1 wh) := '';
EXPORT Make_street_name(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_street_name(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_street_name(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_unit_designator(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_unit_designator(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_unit_designator(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_unit_number(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_unit_number(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_unit_number(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_city(SALT32.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_city(SALT32.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_province(SALT32.StrType s0) := MakeFT_invalid_province(s0);
EXPORT InValid_province(SALT32.StrType s) := InValidFT_invalid_province(s);
EXPORT InValidMessage_province(UNSIGNED1 wh) := InValidMessageFT_invalid_province(wh);
EXPORT Make_postal_code(SALT32.StrType s0) := MakeFT_invalid_canadian_zip(s0);
EXPORT InValid_postal_code(SALT32.StrType s) := InValidFT_invalid_canadian_zip(s);
EXPORT InValidMessage_postal_code(UNSIGNED1 wh) := InValidMessageFT_invalid_canadian_zip(wh);
EXPORT Make_area_code(SALT32.StrType s0) := MakeFT_invalid_area_code(s0);
EXPORT InValid_area_code(SALT32.StrType s) := InValidFT_invalid_area_code(s);
EXPORT InValidMessage_area_code(UNSIGNED1 wh) := InValidMessageFT_invalid_area_code(wh);
EXPORT Make_phone_number(SALT32.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone_number(SALT32.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
EXPORT Make_syph_1(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_syph_1(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_syph_1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_syph_2(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_syph_2(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_syph_2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_syph_3(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_syph_3(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_syph_3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_syph_4(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_syph_4(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_syph_4(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_syph_5(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_syph_5(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_syph_5(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_syph_6(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_syph_6(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_syph_6(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_naics_1(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_naics_1(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_naics_1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_naics_2(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_naics_2(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_naics_2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_naics_3(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_naics_3(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_naics_3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_naics_4(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_naics_4(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_naics_4(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_naics_5(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_naics_5(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_naics_5(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_naics_6(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_naics_6(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_naics_6(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_bdc_1(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdc_1(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdc_1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_bdc_2(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdc_2(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdc_2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_bdc_3(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdc_3(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdc_3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_bdc_4(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdc_4(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdc_4(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_bdc_5(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdc_5(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdc_5(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_bdc_6(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdc_6(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdc_6(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_sic_1(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_sic_1(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_sic_1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_sic_2(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_sic_2(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_sic_2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_sic_3(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_sic_3(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_sic_3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_sic_4(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_sic_4(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_sic_4(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_sic_5(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_sic_5(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_sic_5(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_sic_6(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_sic_6(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_sic_6(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_caption_counter(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_caption_counter(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_caption_counter(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_caption_1(SALT32.StrType s0) := s0;
EXPORT InValid_caption_1(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_caption_1(UNSIGNED1 wh) := '';
EXPORT Make_caption_2(SALT32.StrType s0) := s0;
EXPORT InValid_caption_2(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_caption_2(UNSIGNED1 wh) := '';
EXPORT Make_caption_3(SALT32.StrType s0) := s0;
EXPORT InValid_caption_3(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_caption_3(UNSIGNED1 wh) := '';
EXPORT Make_caption_4(SALT32.StrType s0) := s0;
EXPORT InValid_caption_4(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_caption_4(UNSIGNED1 wh) := '';
EXPORT Make_caption_5(SALT32.StrType s0) := s0;
EXPORT InValid_caption_5(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_caption_5(UNSIGNED1 wh) := '';
EXPORT Make_caption_6(SALT32.StrType s0) := s0;
EXPORT InValid_caption_6(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_caption_6(UNSIGNED1 wh) := '';
EXPORT Make_vanity_city(SALT32.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_vanity_city(SALT32.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_vanity_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_bus_govt_indicator(SALT32.StrType s0) := MakeFT_invalid_bus_govt_indicator(s0);
EXPORT InValid_bus_govt_indicator(SALT32.StrType s) := InValidFT_invalid_bus_govt_indicator(s);
EXPORT InValidMessage_bus_govt_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_bus_govt_indicator(wh);
EXPORT Make_latitude(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_latitude(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_longitude(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_longitude(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_lat_long_level_applied(SALT32.StrType s0) := MakeFT_invalid_lat_long_level_applied(s0);
EXPORT InValid_lat_long_level_applied(SALT32.StrType s) := InValidFT_invalid_lat_long_level_applied(s);
EXPORT InValidMessage_lat_long_level_applied(UNSIGNED1 wh) := InValidMessageFT_invalid_lat_long_level_applied(wh);
EXPORT Make_record_use_indicator(SALT32.StrType s0) := MakeFT_invalid_record_use_indicator(s0);
EXPORT InValid_record_use_indicator(SALT32.StrType s) := InValidFT_invalid_record_use_indicator(s);
EXPORT InValidMessage_record_use_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_record_use_indicator(wh);
EXPORT Make_email(SALT32.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT32.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
EXPORT Make_stated_addr(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_stated_addr(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_stated_addr(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_stated_city(SALT32.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_stated_city(SALT32.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_stated_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_stated_postal_code(SALT32.StrType s0) := MakeFT_invalid_canadian_zip(s0);
EXPORT InValid_stated_postal_code(SALT32.StrType s) := InValidFT_invalid_canadian_zip(s);
EXPORT InValidMessage_stated_postal_code(UNSIGNED1 wh) := InValidMessageFT_invalid_canadian_zip(wh);
EXPORT Make_stated_bus_name(SALT32.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_stated_bus_name(SALT32.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_stated_bus_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_verification_flag(SALT32.StrType s0) := MakeFT_invalid_verification_flag(s0);
EXPORT InValid_verification_flag(SALT32.StrType s) := InValidFT_invalid_verification_flag(s);
EXPORT InValidMessage_verification_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_verification_flag(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,Scrubs_CanadianPhones;
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
    BOOLEAN Diff_record_id;
    BOOLEAN Diff_book_number;
    BOOLEAN Diff_pub_date;
    BOOLEAN Diff_business_name;
    BOOLEAN Diff_street_number;
    BOOLEAN Diff_street_name;
    BOOLEAN Diff_unit_designator;
    BOOLEAN Diff_unit_number;
    BOOLEAN Diff_city;
    BOOLEAN Diff_province;
    BOOLEAN Diff_postal_code;
    BOOLEAN Diff_area_code;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_syph_1;
    BOOLEAN Diff_syph_2;
    BOOLEAN Diff_syph_3;
    BOOLEAN Diff_syph_4;
    BOOLEAN Diff_syph_5;
    BOOLEAN Diff_syph_6;
    BOOLEAN Diff_naics_1;
    BOOLEAN Diff_naics_2;
    BOOLEAN Diff_naics_3;
    BOOLEAN Diff_naics_4;
    BOOLEAN Diff_naics_5;
    BOOLEAN Diff_naics_6;
    BOOLEAN Diff_bdc_1;
    BOOLEAN Diff_bdc_2;
    BOOLEAN Diff_bdc_3;
    BOOLEAN Diff_bdc_4;
    BOOLEAN Diff_bdc_5;
    BOOLEAN Diff_bdc_6;
    BOOLEAN Diff_sic_1;
    BOOLEAN Diff_sic_2;
    BOOLEAN Diff_sic_3;
    BOOLEAN Diff_sic_4;
    BOOLEAN Diff_sic_5;
    BOOLEAN Diff_sic_6;
    BOOLEAN Diff_caption_counter;
    BOOLEAN Diff_caption_1;
    BOOLEAN Diff_caption_2;
    BOOLEAN Diff_caption_3;
    BOOLEAN Diff_caption_4;
    BOOLEAN Diff_caption_5;
    BOOLEAN Diff_caption_6;
    BOOLEAN Diff_vanity_city;
    BOOLEAN Diff_bus_govt_indicator;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_lat_long_level_applied;
    BOOLEAN Diff_record_use_indicator;
    BOOLEAN Diff_email;
    BOOLEAN Diff_stated_addr;
    BOOLEAN Diff_stated_city;
    BOOLEAN Diff_stated_postal_code;
    BOOLEAN Diff_stated_bus_name;
    BOOLEAN Diff_verification_flag;
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_book_number := le.book_number <> ri.book_number;
    SELF.Diff_pub_date := le.pub_date <> ri.pub_date;
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_street_number := le.street_number <> ri.street_number;
    SELF.Diff_street_name := le.street_name <> ri.street_name;
    SELF.Diff_unit_designator := le.unit_designator <> ri.unit_designator;
    SELF.Diff_unit_number := le.unit_number <> ri.unit_number;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_province := le.province <> ri.province;
    SELF.Diff_postal_code := le.postal_code <> ri.postal_code;
    SELF.Diff_area_code := le.area_code <> ri.area_code;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_syph_1 := le.syph_1 <> ri.syph_1;
    SELF.Diff_syph_2 := le.syph_2 <> ri.syph_2;
    SELF.Diff_syph_3 := le.syph_3 <> ri.syph_3;
    SELF.Diff_syph_4 := le.syph_4 <> ri.syph_4;
    SELF.Diff_syph_5 := le.syph_5 <> ri.syph_5;
    SELF.Diff_syph_6 := le.syph_6 <> ri.syph_6;
    SELF.Diff_naics_1 := le.naics_1 <> ri.naics_1;
    SELF.Diff_naics_2 := le.naics_2 <> ri.naics_2;
    SELF.Diff_naics_3 := le.naics_3 <> ri.naics_3;
    SELF.Diff_naics_4 := le.naics_4 <> ri.naics_4;
    SELF.Diff_naics_5 := le.naics_5 <> ri.naics_5;
    SELF.Diff_naics_6 := le.naics_6 <> ri.naics_6;
    SELF.Diff_bdc_1 := le.bdc_1 <> ri.bdc_1;
    SELF.Diff_bdc_2 := le.bdc_2 <> ri.bdc_2;
    SELF.Diff_bdc_3 := le.bdc_3 <> ri.bdc_3;
    SELF.Diff_bdc_4 := le.bdc_4 <> ri.bdc_4;
    SELF.Diff_bdc_5 := le.bdc_5 <> ri.bdc_5;
    SELF.Diff_bdc_6 := le.bdc_6 <> ri.bdc_6;
    SELF.Diff_sic_1 := le.sic_1 <> ri.sic_1;
    SELF.Diff_sic_2 := le.sic_2 <> ri.sic_2;
    SELF.Diff_sic_3 := le.sic_3 <> ri.sic_3;
    SELF.Diff_sic_4 := le.sic_4 <> ri.sic_4;
    SELF.Diff_sic_5 := le.sic_5 <> ri.sic_5;
    SELF.Diff_sic_6 := le.sic_6 <> ri.sic_6;
    SELF.Diff_caption_counter := le.caption_counter <> ri.caption_counter;
    SELF.Diff_caption_1 := le.caption_1 <> ri.caption_1;
    SELF.Diff_caption_2 := le.caption_2 <> ri.caption_2;
    SELF.Diff_caption_3 := le.caption_3 <> ri.caption_3;
    SELF.Diff_caption_4 := le.caption_4 <> ri.caption_4;
    SELF.Diff_caption_5 := le.caption_5 <> ri.caption_5;
    SELF.Diff_caption_6 := le.caption_6 <> ri.caption_6;
    SELF.Diff_vanity_city := le.vanity_city <> ri.vanity_city;
    SELF.Diff_bus_govt_indicator := le.bus_govt_indicator <> ri.bus_govt_indicator;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_lat_long_level_applied := le.lat_long_level_applied <> ri.lat_long_level_applied;
    SELF.Diff_record_use_indicator := le.record_use_indicator <> ri.record_use_indicator;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_stated_addr := le.stated_addr <> ri.stated_addr;
    SELF.Diff_stated_city := le.stated_city <> ri.stated_city;
    SELF.Diff_stated_postal_code := le.stated_postal_code <> ri.stated_postal_code;
    SELF.Diff_stated_bus_name := le.stated_bus_name <> ri.stated_bus_name;
    SELF.Diff_verification_flag := le.verification_flag <> ri.verification_flag;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_book_number,1,0)+ IF( SELF.Diff_pub_date,1,0)+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_street_number,1,0)+ IF( SELF.Diff_street_name,1,0)+ IF( SELF.Diff_unit_designator,1,0)+ IF( SELF.Diff_unit_number,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_province,1,0)+ IF( SELF.Diff_postal_code,1,0)+ IF( SELF.Diff_area_code,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_syph_1,1,0)+ IF( SELF.Diff_syph_2,1,0)+ IF( SELF.Diff_syph_3,1,0)+ IF( SELF.Diff_syph_4,1,0)+ IF( SELF.Diff_syph_5,1,0)+ IF( SELF.Diff_syph_6,1,0)+ IF( SELF.Diff_naics_1,1,0)+ IF( SELF.Diff_naics_2,1,0)+ IF( SELF.Diff_naics_3,1,0)+ IF( SELF.Diff_naics_4,1,0)+ IF( SELF.Diff_naics_5,1,0)+ IF( SELF.Diff_naics_6,1,0)+ IF( SELF.Diff_bdc_1,1,0)+ IF( SELF.Diff_bdc_2,1,0)+ IF( SELF.Diff_bdc_3,1,0)+ IF( SELF.Diff_bdc_4,1,0)+ IF( SELF.Diff_bdc_5,1,0)+ IF( SELF.Diff_bdc_6,1,0)+ IF( SELF.Diff_sic_1,1,0)+ IF( SELF.Diff_sic_2,1,0)+ IF( SELF.Diff_sic_3,1,0)+ IF( SELF.Diff_sic_4,1,0)+ IF( SELF.Diff_sic_5,1,0)+ IF( SELF.Diff_sic_6,1,0)+ IF( SELF.Diff_caption_counter,1,0)+ IF( SELF.Diff_caption_1,1,0)+ IF( SELF.Diff_caption_2,1,0)+ IF( SELF.Diff_caption_3,1,0)+ IF( SELF.Diff_caption_4,1,0)+ IF( SELF.Diff_caption_5,1,0)+ IF( SELF.Diff_caption_6,1,0)+ IF( SELF.Diff_vanity_city,1,0)+ IF( SELF.Diff_bus_govt_indicator,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_lat_long_level_applied,1,0)+ IF( SELF.Diff_record_use_indicator,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_stated_addr,1,0)+ IF( SELF.Diff_stated_city,1,0)+ IF( SELF.Diff_stated_postal_code,1,0)+ IF( SELF.Diff_stated_bus_name,1,0)+ IF( SELF.Diff_verification_flag,1,0);
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
    Count_Diff_record_id := COUNT(GROUP,%Closest%.Diff_record_id);
    Count_Diff_book_number := COUNT(GROUP,%Closest%.Diff_book_number);
    Count_Diff_pub_date := COUNT(GROUP,%Closest%.Diff_pub_date);
    Count_Diff_business_name := COUNT(GROUP,%Closest%.Diff_business_name);
    Count_Diff_street_number := COUNT(GROUP,%Closest%.Diff_street_number);
    Count_Diff_street_name := COUNT(GROUP,%Closest%.Diff_street_name);
    Count_Diff_unit_designator := COUNT(GROUP,%Closest%.Diff_unit_designator);
    Count_Diff_unit_number := COUNT(GROUP,%Closest%.Diff_unit_number);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_province := COUNT(GROUP,%Closest%.Diff_province);
    Count_Diff_postal_code := COUNT(GROUP,%Closest%.Diff_postal_code);
    Count_Diff_area_code := COUNT(GROUP,%Closest%.Diff_area_code);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_syph_1 := COUNT(GROUP,%Closest%.Diff_syph_1);
    Count_Diff_syph_2 := COUNT(GROUP,%Closest%.Diff_syph_2);
    Count_Diff_syph_3 := COUNT(GROUP,%Closest%.Diff_syph_3);
    Count_Diff_syph_4 := COUNT(GROUP,%Closest%.Diff_syph_4);
    Count_Diff_syph_5 := COUNT(GROUP,%Closest%.Diff_syph_5);
    Count_Diff_syph_6 := COUNT(GROUP,%Closest%.Diff_syph_6);
    Count_Diff_naics_1 := COUNT(GROUP,%Closest%.Diff_naics_1);
    Count_Diff_naics_2 := COUNT(GROUP,%Closest%.Diff_naics_2);
    Count_Diff_naics_3 := COUNT(GROUP,%Closest%.Diff_naics_3);
    Count_Diff_naics_4 := COUNT(GROUP,%Closest%.Diff_naics_4);
    Count_Diff_naics_5 := COUNT(GROUP,%Closest%.Diff_naics_5);
    Count_Diff_naics_6 := COUNT(GROUP,%Closest%.Diff_naics_6);
    Count_Diff_bdc_1 := COUNT(GROUP,%Closest%.Diff_bdc_1);
    Count_Diff_bdc_2 := COUNT(GROUP,%Closest%.Diff_bdc_2);
    Count_Diff_bdc_3 := COUNT(GROUP,%Closest%.Diff_bdc_3);
    Count_Diff_bdc_4 := COUNT(GROUP,%Closest%.Diff_bdc_4);
    Count_Diff_bdc_5 := COUNT(GROUP,%Closest%.Diff_bdc_5);
    Count_Diff_bdc_6 := COUNT(GROUP,%Closest%.Diff_bdc_6);
    Count_Diff_sic_1 := COUNT(GROUP,%Closest%.Diff_sic_1);
    Count_Diff_sic_2 := COUNT(GROUP,%Closest%.Diff_sic_2);
    Count_Diff_sic_3 := COUNT(GROUP,%Closest%.Diff_sic_3);
    Count_Diff_sic_4 := COUNT(GROUP,%Closest%.Diff_sic_4);
    Count_Diff_sic_5 := COUNT(GROUP,%Closest%.Diff_sic_5);
    Count_Diff_sic_6 := COUNT(GROUP,%Closest%.Diff_sic_6);
    Count_Diff_caption_counter := COUNT(GROUP,%Closest%.Diff_caption_counter);
    Count_Diff_caption_1 := COUNT(GROUP,%Closest%.Diff_caption_1);
    Count_Diff_caption_2 := COUNT(GROUP,%Closest%.Diff_caption_2);
    Count_Diff_caption_3 := COUNT(GROUP,%Closest%.Diff_caption_3);
    Count_Diff_caption_4 := COUNT(GROUP,%Closest%.Diff_caption_4);
    Count_Diff_caption_5 := COUNT(GROUP,%Closest%.Diff_caption_5);
    Count_Diff_caption_6 := COUNT(GROUP,%Closest%.Diff_caption_6);
    Count_Diff_vanity_city := COUNT(GROUP,%Closest%.Diff_vanity_city);
    Count_Diff_bus_govt_indicator := COUNT(GROUP,%Closest%.Diff_bus_govt_indicator);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_lat_long_level_applied := COUNT(GROUP,%Closest%.Diff_lat_long_level_applied);
    Count_Diff_record_use_indicator := COUNT(GROUP,%Closest%.Diff_record_use_indicator);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_stated_addr := COUNT(GROUP,%Closest%.Diff_stated_addr);
    Count_Diff_stated_city := COUNT(GROUP,%Closest%.Diff_stated_city);
    Count_Diff_stated_postal_code := COUNT(GROUP,%Closest%.Diff_stated_postal_code);
    Count_Diff_stated_bus_name := COUNT(GROUP,%Closest%.Diff_stated_bus_name);
    Count_Diff_verification_flag := COUNT(GROUP,%Closest%.Diff_verification_flag);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
