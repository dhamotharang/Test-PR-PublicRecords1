IMPORT ut,SALT32;
EXPORT Axciom_Res_Fields := MODULE
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_record_id','invalid_date','invalid_date1','invalid_area_code','invalid_phone','invalid_numeric','invalid_alpha','invalid_alnum','invalid_address','invalid_city','invalid_name','invalid_mid_init','invalid_canadian_zip','invalid_province','invalid_lat_long_level_applied','invalid_record_use_indicator','invalid_bus_govt_indicator','invalid_email','invalid_section_type','invalid_status_code');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'invalid_record_id' => 1,'invalid_date' => 2,'invalid_date1' => 3,'invalid_area_code' => 4,'invalid_phone' => 5,'invalid_numeric' => 6,'invalid_alpha' => 7,'invalid_alnum' => 8,'invalid_address' => 9,'invalid_city' => 10,'invalid_name' => 11,'invalid_mid_init' => 12,'invalid_canadian_zip' => 13,'invalid_province' => 14,'invalid_lat_long_level_applied' => 15,'invalid_record_use_indicator' => 16,'invalid_bus_govt_indicator' => 17,'invalid_email' => 18,'invalid_section_type' => 19,'invalid_status_code' => 20,0);
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
EXPORT MakeFT_invalid_date1(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date1(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date1(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.NotLength('8,0'),SALT32.HygieneErrors.Good);
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
  s1 := SALT32.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -\'/.'); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' -\'/.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -\'/.'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -\'/.'),SALT32.HygieneErrors.NotLength('0..'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_alnum(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'. -/'); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' -/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alnum(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'. -/'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alnum(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'. -/'),SALT32.HygieneErrors.NotLength('0..'),SALT32.HygieneErrors.Good);
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
  s1 := SALT32.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ,.(){}/\\;'); // Only allow valid symbols
  s2 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s1,' ,.(){}/\\;',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ,.(){}/\\;'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ,.(){}/\\;'),SALT32.HygieneErrors.NotLength('0..'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_mid_init(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_mid_init(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_mid_init(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.Good);
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
EXPORT MakeFT_invalid_section_type(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_section_type(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['C','M',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_section_type(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('C|M|'),SALT32.HygieneErrors.NotLength('1,0'),SALT32.HygieneErrors.Good);
EXPORT MakeFT_invalid_status_code(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'GD0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_status_code(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'GD0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_status_code(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('GD0123456789'),SALT32.HygieneErrors.NotLength('4,0'),SALT32.HygieneErrors.Good);
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'record_id','book_number','pub_date','section_number','page_number','status_code','load_date','section_type','first_name','middle_initial','last_name','generational_suffix','primary_prefix_title_code','primary_professional_suffix_code','street_number','street_name','unit_number','unit_designator','city','province','postal_code','area_code','phone_number','vanity_city_name','latitude','longitude','lat_long_level_applied','record_use_indicator','email','stated_address','stated_city','stated_postal_code');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'record_id' => 0,'book_number' => 1,'pub_date' => 2,'section_number' => 3,'page_number' => 4,'status_code' => 5,'load_date' => 6,'section_type' => 7,'first_name' => 8,'middle_initial' => 9,'last_name' => 10,'generational_suffix' => 11,'primary_prefix_title_code' => 12,'primary_professional_suffix_code' => 13,'street_number' => 14,'street_name' => 15,'unit_number' => 16,'unit_designator' => 17,'city' => 18,'province' => 19,'postal_code' => 20,'area_code' => 21,'phone_number' => 22,'vanity_city_name' => 23,'latitude' => 24,'longitude' => 25,'lat_long_level_applied' => 26,'record_use_indicator' => 27,'email' => 28,'stated_address' => 29,'stated_city' => 30,'stated_postal_code' => 31,0);
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
EXPORT Make_section_number(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_section_number(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_section_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_page_number(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_page_number(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_page_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_status_code(SALT32.StrType s0) := MakeFT_invalid_status_code(s0);
EXPORT InValid_status_code(SALT32.StrType s) := InValidFT_invalid_status_code(s);
EXPORT InValidMessage_status_code(UNSIGNED1 wh) := InValidMessageFT_invalid_status_code(wh);
EXPORT Make_load_date(SALT32.StrType s0) := MakeFT_invalid_date1(s0);
EXPORT InValid_load_date(SALT32.StrType s) := InValidFT_invalid_date1(s);
EXPORT InValidMessage_load_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date1(wh);
EXPORT Make_section_type(SALT32.StrType s0) := MakeFT_invalid_section_type(s0);
EXPORT InValid_section_type(SALT32.StrType s) := InValidFT_invalid_section_type(s);
EXPORT InValidMessage_section_type(UNSIGNED1 wh) := InValidMessageFT_invalid_section_type(wh);
EXPORT Make_first_name(SALT32.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_first_name(SALT32.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_middle_initial(SALT32.StrType s0) := MakeFT_invalid_mid_init(s0);
EXPORT InValid_middle_initial(SALT32.StrType s) := InValidFT_invalid_mid_init(s);
EXPORT InValidMessage_middle_initial(UNSIGNED1 wh) := InValidMessageFT_invalid_mid_init(wh);
EXPORT Make_last_name(SALT32.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_last_name(SALT32.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_generational_suffix(SALT32.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_generational_suffix(SALT32.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_generational_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_primary_prefix_title_code(SALT32.StrType s0) := s0;
EXPORT InValid_primary_prefix_title_code(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_primary_prefix_title_code(UNSIGNED1 wh) := '';
EXPORT Make_primary_professional_suffix_code(SALT32.StrType s0) := s0;
EXPORT InValid_primary_professional_suffix_code(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_primary_professional_suffix_code(UNSIGNED1 wh) := '';
EXPORT Make_street_number(SALT32.StrType s0) := MakeFT_invalid_alnum(s0);
EXPORT InValid_street_number(SALT32.StrType s) := InValidFT_invalid_alnum(s);
EXPORT InValidMessage_street_number(UNSIGNED1 wh) := InValidMessageFT_invalid_alnum(wh);
EXPORT Make_street_name(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_street_name(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_street_name(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_unit_number(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_unit_number(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_unit_number(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_unit_designator(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_unit_designator(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_unit_designator(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
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
EXPORT Make_vanity_city_name(SALT32.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_vanity_city_name(SALT32.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_vanity_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
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
EXPORT Make_stated_address(SALT32.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_stated_address(SALT32.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_stated_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_stated_city(SALT32.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_stated_city(SALT32.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_stated_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_stated_postal_code(SALT32.StrType s0) := MakeFT_invalid_canadian_zip(s0);
EXPORT InValid_stated_postal_code(SALT32.StrType s) := InValidFT_invalid_canadian_zip(s);
EXPORT InValidMessage_stated_postal_code(UNSIGNED1 wh) := InValidMessageFT_invalid_canadian_zip(wh);
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
    BOOLEAN Diff_section_number;
    BOOLEAN Diff_page_number;
    BOOLEAN Diff_status_code;
    BOOLEAN Diff_load_date;
    BOOLEAN Diff_section_type;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_initial;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_generational_suffix;
    BOOLEAN Diff_primary_prefix_title_code;
    BOOLEAN Diff_primary_professional_suffix_code;
    BOOLEAN Diff_street_number;
    BOOLEAN Diff_street_name;
    BOOLEAN Diff_unit_number;
    BOOLEAN Diff_unit_designator;
    BOOLEAN Diff_city;
    BOOLEAN Diff_province;
    BOOLEAN Diff_postal_code;
    BOOLEAN Diff_area_code;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_vanity_city_name;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_lat_long_level_applied;
    BOOLEAN Diff_record_use_indicator;
    BOOLEAN Diff_email;
    BOOLEAN Diff_stated_address;
    BOOLEAN Diff_stated_city;
    BOOLEAN Diff_stated_postal_code;
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_book_number := le.book_number <> ri.book_number;
    SELF.Diff_pub_date := le.pub_date <> ri.pub_date;
    SELF.Diff_section_number := le.section_number <> ri.section_number;
    SELF.Diff_page_number := le.page_number <> ri.page_number;
    SELF.Diff_status_code := le.status_code <> ri.status_code;
    SELF.Diff_load_date := le.load_date <> ri.load_date;
    SELF.Diff_section_type := le.section_type <> ri.section_type;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_initial := le.middle_initial <> ri.middle_initial;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_generational_suffix := le.generational_suffix <> ri.generational_suffix;
    SELF.Diff_primary_prefix_title_code := le.primary_prefix_title_code <> ri.primary_prefix_title_code;
    SELF.Diff_primary_professional_suffix_code := le.primary_professional_suffix_code <> ri.primary_professional_suffix_code;
    SELF.Diff_street_number := le.street_number <> ri.street_number;
    SELF.Diff_street_name := le.street_name <> ri.street_name;
    SELF.Diff_unit_number := le.unit_number <> ri.unit_number;
    SELF.Diff_unit_designator := le.unit_designator <> ri.unit_designator;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_province := le.province <> ri.province;
    SELF.Diff_postal_code := le.postal_code <> ri.postal_code;
    SELF.Diff_area_code := le.area_code <> ri.area_code;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_vanity_city_name := le.vanity_city_name <> ri.vanity_city_name;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_lat_long_level_applied := le.lat_long_level_applied <> ri.lat_long_level_applied;
    SELF.Diff_record_use_indicator := le.record_use_indicator <> ri.record_use_indicator;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_stated_address := le.stated_address <> ri.stated_address;
    SELF.Diff_stated_city := le.stated_city <> ri.stated_city;
    SELF.Diff_stated_postal_code := le.stated_postal_code <> ri.stated_postal_code;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_book_number,1,0)+ IF( SELF.Diff_pub_date,1,0)+ IF( SELF.Diff_section_number,1,0)+ IF( SELF.Diff_page_number,1,0)+ IF( SELF.Diff_status_code,1,0)+ IF( SELF.Diff_load_date,1,0)+ IF( SELF.Diff_section_type,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_initial,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_generational_suffix,1,0)+ IF( SELF.Diff_primary_prefix_title_code,1,0)+ IF( SELF.Diff_primary_professional_suffix_code,1,0)+ IF( SELF.Diff_street_number,1,0)+ IF( SELF.Diff_street_name,1,0)+ IF( SELF.Diff_unit_number,1,0)+ IF( SELF.Diff_unit_designator,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_province,1,0)+ IF( SELF.Diff_postal_code,1,0)+ IF( SELF.Diff_area_code,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_vanity_city_name,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_lat_long_level_applied,1,0)+ IF( SELF.Diff_record_use_indicator,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_stated_address,1,0)+ IF( SELF.Diff_stated_city,1,0)+ IF( SELF.Diff_stated_postal_code,1,0);
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
    Count_Diff_section_number := COUNT(GROUP,%Closest%.Diff_section_number);
    Count_Diff_page_number := COUNT(GROUP,%Closest%.Diff_page_number);
    Count_Diff_status_code := COUNT(GROUP,%Closest%.Diff_status_code);
    Count_Diff_load_date := COUNT(GROUP,%Closest%.Diff_load_date);
    Count_Diff_section_type := COUNT(GROUP,%Closest%.Diff_section_type);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_initial := COUNT(GROUP,%Closest%.Diff_middle_initial);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_generational_suffix := COUNT(GROUP,%Closest%.Diff_generational_suffix);
    Count_Diff_primary_prefix_title_code := COUNT(GROUP,%Closest%.Diff_primary_prefix_title_code);
    Count_Diff_primary_professional_suffix_code := COUNT(GROUP,%Closest%.Diff_primary_professional_suffix_code);
    Count_Diff_street_number := COUNT(GROUP,%Closest%.Diff_street_number);
    Count_Diff_street_name := COUNT(GROUP,%Closest%.Diff_street_name);
    Count_Diff_unit_number := COUNT(GROUP,%Closest%.Diff_unit_number);
    Count_Diff_unit_designator := COUNT(GROUP,%Closest%.Diff_unit_designator);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_province := COUNT(GROUP,%Closest%.Diff_province);
    Count_Diff_postal_code := COUNT(GROUP,%Closest%.Diff_postal_code);
    Count_Diff_area_code := COUNT(GROUP,%Closest%.Diff_area_code);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_vanity_city_name := COUNT(GROUP,%Closest%.Diff_vanity_city_name);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_lat_long_level_applied := COUNT(GROUP,%Closest%.Diff_lat_long_level_applied);
    Count_Diff_record_use_indicator := COUNT(GROUP,%Closest%.Diff_record_use_indicator);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_stated_address := COUNT(GROUP,%Closest%.Diff_stated_address);
    Count_Diff_stated_city := COUNT(GROUP,%Closest%.Diff_stated_city);
    Count_Diff_stated_postal_code := COUNT(GROUP,%Closest%.Diff_stated_postal_code);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
