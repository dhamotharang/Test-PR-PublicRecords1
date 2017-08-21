IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_record_id','invalid_pubdate','invalid_yppa_code','invalid_book_code','invalid_page_number','invalid_record_number','invalid_phone_number','invalid_phone_type','invalid_record_type','invalid_no_solicitation_code','invalid_raw_name','invalid_name','invalid_job_title','invalid_house_number','invalid_street_name','invalid_street_type','invalid_apt_type','invalid_apt_number','invalid_box_number','invalid_delivery_point_code','invalid_carrier_route','invalid_gnrl_address_return_code','invalid_address_flag','invalid_validation_flag','invalid_postal_city_name','invalid_county_code_','invalid_rec_type','invalid_prim_range','invalid_predir','invalid_prim_name','invalid_suffix','invalid_postdir','invalid_unit_desig','invalid_sec_range','invalid_city_name','invalid_st','invalid_zip','invalid_zip4','invalid_county','invalid_cbsa','invalid_geo_blk','invalid_address','invalid_longdate','invalid_shortdate','invalid_cleanaddress');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_record_id' => 1,'invalid_pubdate' => 2,'invalid_yppa_code' => 3,'invalid_book_code' => 4,'invalid_page_number' => 5,'invalid_record_number' => 6,'invalid_phone_number' => 7,'invalid_phone_type' => 8,'invalid_record_type' => 9,'invalid_no_solicitation_code' => 10,'invalid_raw_name' => 11,'invalid_name' => 12,'invalid_job_title' => 13,'invalid_house_number' => 14,'invalid_street_name' => 15,'invalid_street_type' => 16,'invalid_apt_type' => 17,'invalid_apt_number' => 18,'invalid_box_number' => 19,'invalid_delivery_point_code' => 20,'invalid_carrier_route' => 21,'invalid_gnrl_address_return_code' => 22,'invalid_address_flag' => 23,'invalid_validation_flag' => 24,'invalid_postal_city_name' => 25,'invalid_county_code_' => 26,'invalid_rec_type' => 27,'invalid_prim_range' => 28,'invalid_predir' => 29,'invalid_prim_name' => 30,'invalid_suffix' => 31,'invalid_postdir' => 32,'invalid_unit_desig' => 33,'invalid_sec_range' => 34,'invalid_city_name' => 35,'invalid_st' => 36,'invalid_zip' => 37,'invalid_zip4' => 38,'invalid_county' => 39,'invalid_cbsa' => 40,'invalid_geo_blk' => 41,'invalid_address' => 42,'invalid_longdate' => 43,'invalid_shortdate' => 44,'invalid_cleanaddress' => 45,0);
EXPORT MakeFT_invalid_record_id(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_record_id(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 7 AND LENGTH(TRIM(s)) <= 12));
EXPORT InValidMessageFT_invalid_record_id(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('7..12'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_pubdate(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pubdate(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_pubdate(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('6,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_yppa_code(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_yppa_code(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 6));
EXPORT InValidMessageFT_invalid_yppa_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('6'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_book_code(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_book_code(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_book_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT30.HygieneErrors.NotLength('3,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_page_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_page_number(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_page_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_record_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_record_number(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_record_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_phone_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789X'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone_number(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789X'))),~(LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_phone_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789X'),SALT30.HygieneErrors.NotLength('10'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_phone_type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone_type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_phone_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_record_type(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['R','O','P','S']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('R|O|P|S'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_no_solicitation_code(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_no_solicitation_code(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['T','N','*','']);
EXPORT InValidMessageFT_invalid_no_solicitation_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('T|N|*|'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_raw_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¢Ã©Ã¶Ã¸abcdefghijklmnopqrstuvwxyz0123456789 /\\@Â¸:+$?_;,=![]-\'`"()&.*#'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /\\@Â¸:+$?_;,=![]-\'`"()&.*#',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_raw_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¢Ã©Ã¶Ã¸abcdefghijklmnopqrstuvwxyz0123456789 /\\@Â¸:+$?_;,=![]-\'`"()&.*#'))));
EXPORT InValidMessageFT_invalid_raw_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¢Ã©Ã¶Ã¸abcdefghijklmnopqrstuvwxyz0123456789 /\\@Â¸:+$?_;,=![]-\'`"()&.*#'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã© -0123456789?'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -0123456789?',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã© -0123456789?'))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã© -0123456789?'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_job_title(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\-$"'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /\\-$"',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_job_title(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\-$"'))));
EXPORT InValidMessageFT_invalid_job_title(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\-$"'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_house_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\-.'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /\\-.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_house_number(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\-.'))));
EXPORT InValidMessageFT_invalid_house_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\-.'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_street_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\.-&#'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /\\.-&#',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_street_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\.-&#'))));
EXPORT InValidMessageFT_invalid_street_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\.-&#'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_street_type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz /\\.-&#'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /\\.-&#',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_street_type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz /\\.-&#'))));
EXPORT InValidMessageFT_invalid_street_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz /\\.-&#'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_apt_type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz #'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' #',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_apt_type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz #'))));
EXPORT InValidMessageFT_invalid_apt_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz #'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_apt_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\-.'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /\\-.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_apt_number(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\-.'))));
EXPORT InValidMessageFT_invalid_apt_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\-.'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_box_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\()-&'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /\\()-&',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_box_number(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\()-&'))));
EXPORT InValidMessageFT_invalid_box_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\()-&'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_delivery_point_code(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_delivery_point_code(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_delivery_point_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('3,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_carrier_route(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'BCGHR0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_carrier_route(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'BCGHR0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_carrier_route(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('BCGHR0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_gnrl_address_return_code(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gnrl_address_return_code(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_gnrl_address_return_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_address_flag(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'DN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_address_flag(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'DN'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_address_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('DN'),SALT30.HygieneErrors.NotLength('1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_validation_flag(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'C '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_validation_flag(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'C '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_validation_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('C '),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_postal_city_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\()*-.\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /\\()*-.\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_postal_city_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\()*-.\''))));
EXPORT InValidMessageFT_invalid_postal_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\()*-.\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_county_code_(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_county_code_(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_county_code_(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('5,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_rec_type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'12'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_rec_type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'12'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('12'),SALT30.HygieneErrors.NotLength('1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_prim_range(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ./\\Â½-'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ./\\Â½-',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_prim_range(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ./\\Â½-'))));
EXPORT InValidMessageFT_invalid_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ./\\Â½-'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_predir(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'NSEW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_predir(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'NSEW'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_invalid_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('NSEW'),SALT30.HygieneErrors.NotLength('0..2'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_prim_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Ã‘ -/\\\'.&'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -/\\\'.&',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_prim_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Ã‘ -/\\\'.&'))));
EXPORT InValidMessageFT_invalid_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Ã‘ -/\\\'.&'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_suffix(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_suffix(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_postdir(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'NSEW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_postdir(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'NSEW'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_invalid_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('NSEW'),SALT30.HygieneErrors.NotLength('0..2'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_unit_desig(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\'#'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -.\'#',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_unit_desig(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\'#'))));
EXPORT InValidMessageFT_invalid_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -.\'#'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_sec_range(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\'#/&'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -.\'#/&',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_sec_range(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\'#/&'))));
EXPORT InValidMessageFT_invalid_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.\'#/&'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_city_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\-.\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /\\-.\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_city_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\-.\''))));
EXPORT InValidMessageFT_invalid_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /\\-.\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_st(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_st(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('5,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip4(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip4(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('4,1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_county(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_county(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_county(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('3,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_cbsa(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_cbsa(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_cbsa(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789 '),SALT30.HygieneErrors.NotLength('5'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_geo_blk(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo_blk(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('7,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_address(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘Ã0123456789 ,-.()\':;"&#/'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ,-.()\':;"&#/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘Ã0123456789 ,-.()\':;"&#/'))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘Ã0123456789 ,-.()\':;"&#/'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_longdate(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_longdate(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_longdate(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('8,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_shortdate(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_shortdate(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_shortdate(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('6,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_cleanaddress(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\&()#*-.\''); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' /\\&()#*-.\'',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_cleanaddress(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\&()#*-.\''))));
EXPORT InValidMessageFT_invalid_cleanaddress(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\&()#*-.\''),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'record_id','pubdate','filler','yppa_code','book_code','page_number','record_number','phone_number','phone_type','record_type','no_solicitation_code','title','first_name','middle_name','last_name','last_name_suffix','job_title','secondary_name_title','secondary_first_name','secondary_middle_name','secondary_name_suffix','house_number','pre_direction','street_name','street_type','post_direction','apt_type','apt_number','box_number','expanded_pub_city_name','postal_city_name','state','z5','plus4','delivery_point_code','carrier_route','county_code_','gnrl_address_return_code','house_number_usage_flag','pre_direction_usage_flag','street_name_usage_flag','street_type_usage_flag','post_direction_usage_flag','apt_number_usage_flag','validation_date','validation_flag','filler1','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','rec_type','hhid','did','did_score','fname','minit','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','county','cbsa','geo_blk','cleanname','cleanaddress','active');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'record_id' => 1,'pubdate' => 2,'filler' => 3,'yppa_code' => 4,'book_code' => 5,'page_number' => 6,'record_number' => 7,'phone_number' => 8,'phone_type' => 9,'record_type' => 10,'no_solicitation_code' => 11,'title' => 12,'first_name' => 13,'middle_name' => 14,'last_name' => 15,'last_name_suffix' => 16,'job_title' => 17,'secondary_name_title' => 18,'secondary_first_name' => 19,'secondary_middle_name' => 20,'secondary_name_suffix' => 21,'house_number' => 22,'pre_direction' => 23,'street_name' => 24,'street_type' => 25,'post_direction' => 26,'apt_type' => 27,'apt_number' => 28,'box_number' => 29,'expanded_pub_city_name' => 30,'postal_city_name' => 31,'state' => 32,'z5' => 33,'plus4' => 34,'delivery_point_code' => 35,'carrier_route' => 36,'county_code_' => 37,'gnrl_address_return_code' => 38,'house_number_usage_flag' => 39,'pre_direction_usage_flag' => 40,'street_name_usage_flag' => 41,'street_type_usage_flag' => 42,'post_direction_usage_flag' => 43,'apt_number_usage_flag' => 44,'validation_date' => 45,'validation_flag' => 46,'filler1' => 47,'dt_first_seen' => 48,'dt_last_seen' => 49,'dt_vendor_last_reported' => 50,'dt_vendor_first_reported' => 51,'rec_type' => 52,'hhid' => 53,'did' => 54,'did_score' => 55,'fname' => 56,'minit' => 57,'lname' => 58,'name_suffix' => 59,'prim_range' => 60,'predir' => 61,'prim_name' => 62,'suffix' => 63,'postdir' => 64,'unit_desig' => 65,'sec_range' => 66,'city_name' => 67,'st' => 68,'zip' => 69,'zip4' => 70,'county' => 71,'cbsa' => 72,'geo_blk' => 73,'cleanname' => 74,'cleanaddress' => 75,'active' => 76,0);
//Individual field level validation
EXPORT Make_record_id(SALT30.StrType s0) := MakeFT_invalid_record_id(s0);
EXPORT InValid_record_id(SALT30.StrType s) := InValidFT_invalid_record_id(s);
EXPORT InValidMessage_record_id(UNSIGNED1 wh) := InValidMessageFT_invalid_record_id(wh);
EXPORT Make_pubdate(SALT30.StrType s0) := MakeFT_invalid_pubdate(s0);
EXPORT InValid_pubdate(SALT30.StrType s) := InValidFT_invalid_pubdate(s);
EXPORT InValidMessage_pubdate(UNSIGNED1 wh) := InValidMessageFT_invalid_pubdate(wh);
EXPORT Make_filler(SALT30.StrType s0) := s0;
EXPORT InValid_filler(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_filler(UNSIGNED1 wh) := '';
EXPORT Make_yppa_code(SALT30.StrType s0) := MakeFT_invalid_yppa_code(s0);
EXPORT InValid_yppa_code(SALT30.StrType s) := InValidFT_invalid_yppa_code(s);
EXPORT InValidMessage_yppa_code(UNSIGNED1 wh) := InValidMessageFT_invalid_yppa_code(wh);
EXPORT Make_book_code(SALT30.StrType s0) := MakeFT_invalid_book_code(s0);
EXPORT InValid_book_code(SALT30.StrType s) := InValidFT_invalid_book_code(s);
EXPORT InValidMessage_book_code(UNSIGNED1 wh) := InValidMessageFT_invalid_book_code(wh);
EXPORT Make_page_number(SALT30.StrType s0) := MakeFT_invalid_page_number(s0);
EXPORT InValid_page_number(SALT30.StrType s) := InValidFT_invalid_page_number(s);
EXPORT InValidMessage_page_number(UNSIGNED1 wh) := InValidMessageFT_invalid_page_number(wh);
EXPORT Make_record_number(SALT30.StrType s0) := MakeFT_invalid_record_number(s0);
EXPORT InValid_record_number(SALT30.StrType s) := InValidFT_invalid_record_number(s);
EXPORT InValidMessage_record_number(UNSIGNED1 wh) := InValidMessageFT_invalid_record_number(wh);
EXPORT Make_phone_number(SALT30.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phone_number(SALT30.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_phone_type(SALT30.StrType s0) := MakeFT_invalid_phone_type(s0);
EXPORT InValid_phone_type(SALT30.StrType s) := InValidFT_invalid_phone_type(s);
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_type(wh);
EXPORT Make_record_type(SALT30.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT30.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
EXPORT Make_no_solicitation_code(SALT30.StrType s0) := MakeFT_invalid_no_solicitation_code(s0);
EXPORT InValid_no_solicitation_code(SALT30.StrType s) := InValidFT_invalid_no_solicitation_code(s);
EXPORT InValidMessage_no_solicitation_code(UNSIGNED1 wh) := InValidMessageFT_invalid_no_solicitation_code(wh);
EXPORT Make_title(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_title(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_first_name(SALT30.StrType s0) := MakeFT_invalid_raw_name(s0);
EXPORT InValid_first_name(SALT30.StrType s) := InValidFT_invalid_raw_name(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_name(wh);
EXPORT Make_middle_name(SALT30.StrType s0) := MakeFT_invalid_raw_name(s0);
EXPORT InValid_middle_name(SALT30.StrType s) := InValidFT_invalid_raw_name(s);
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_name(wh);
EXPORT Make_last_name(SALT30.StrType s0) := MakeFT_invalid_raw_name(s0);
EXPORT InValid_last_name(SALT30.StrType s) := InValidFT_invalid_raw_name(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_name(wh);
EXPORT Make_last_name_suffix(SALT30.StrType s0) := MakeFT_invalid_raw_name(s0);
EXPORT InValid_last_name_suffix(SALT30.StrType s) := InValidFT_invalid_raw_name(s);
EXPORT InValidMessage_last_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_name(wh);
EXPORT Make_job_title(SALT30.StrType s0) := MakeFT_invalid_job_title(s0);
EXPORT InValid_job_title(SALT30.StrType s) := InValidFT_invalid_job_title(s);
EXPORT InValidMessage_job_title(UNSIGNED1 wh) := InValidMessageFT_invalid_job_title(wh);
EXPORT Make_secondary_name_title(SALT30.StrType s0) := MakeFT_invalid_raw_name(s0);
EXPORT InValid_secondary_name_title(SALT30.StrType s) := InValidFT_invalid_raw_name(s);
EXPORT InValidMessage_secondary_name_title(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_name(wh);
EXPORT Make_secondary_first_name(SALT30.StrType s0) := MakeFT_invalid_raw_name(s0);
EXPORT InValid_secondary_first_name(SALT30.StrType s) := InValidFT_invalid_raw_name(s);
EXPORT InValidMessage_secondary_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_name(wh);
EXPORT Make_secondary_middle_name(SALT30.StrType s0) := MakeFT_invalid_raw_name(s0);
EXPORT InValid_secondary_middle_name(SALT30.StrType s) := InValidFT_invalid_raw_name(s);
EXPORT InValidMessage_secondary_middle_name(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_name(wh);
EXPORT Make_secondary_name_suffix(SALT30.StrType s0) := MakeFT_invalid_raw_name(s0);
EXPORT InValid_secondary_name_suffix(SALT30.StrType s) := InValidFT_invalid_raw_name(s);
EXPORT InValidMessage_secondary_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_name(wh);
EXPORT Make_house_number(SALT30.StrType s0) := MakeFT_invalid_house_number(s0);
EXPORT InValid_house_number(SALT30.StrType s) := InValidFT_invalid_house_number(s);
EXPORT InValidMessage_house_number(UNSIGNED1 wh) := InValidMessageFT_invalid_house_number(wh);
EXPORT Make_pre_direction(SALT30.StrType s0) := MakeFT_invalid_predir(s0);
EXPORT InValid_pre_direction(SALT30.StrType s) := InValidFT_invalid_predir(s);
EXPORT InValidMessage_pre_direction(UNSIGNED1 wh) := InValidMessageFT_invalid_predir(wh);
EXPORT Make_street_name(SALT30.StrType s0) := MakeFT_invalid_street_name(s0);
EXPORT InValid_street_name(SALT30.StrType s) := InValidFT_invalid_street_name(s);
EXPORT InValidMessage_street_name(UNSIGNED1 wh) := InValidMessageFT_invalid_street_name(wh);
EXPORT Make_street_type(SALT30.StrType s0) := MakeFT_invalid_street_type(s0);
EXPORT InValid_street_type(SALT30.StrType s) := InValidFT_invalid_street_type(s);
EXPORT InValidMessage_street_type(UNSIGNED1 wh) := InValidMessageFT_invalid_street_type(wh);
EXPORT Make_post_direction(SALT30.StrType s0) := MakeFT_invalid_predir(s0);
EXPORT InValid_post_direction(SALT30.StrType s) := InValidFT_invalid_predir(s);
EXPORT InValidMessage_post_direction(UNSIGNED1 wh) := InValidMessageFT_invalid_predir(wh);
EXPORT Make_apt_type(SALT30.StrType s0) := MakeFT_invalid_apt_type(s0);
EXPORT InValid_apt_type(SALT30.StrType s) := InValidFT_invalid_apt_type(s);
EXPORT InValidMessage_apt_type(UNSIGNED1 wh) := InValidMessageFT_invalid_apt_type(wh);
EXPORT Make_apt_number(SALT30.StrType s0) := MakeFT_invalid_apt_number(s0);
EXPORT InValid_apt_number(SALT30.StrType s) := InValidFT_invalid_apt_number(s);
EXPORT InValidMessage_apt_number(UNSIGNED1 wh) := InValidMessageFT_invalid_apt_number(wh);
EXPORT Make_box_number(SALT30.StrType s0) := MakeFT_invalid_box_number(s0);
EXPORT InValid_box_number(SALT30.StrType s) := InValidFT_invalid_box_number(s);
EXPORT InValidMessage_box_number(UNSIGNED1 wh) := InValidMessageFT_invalid_box_number(wh);
EXPORT Make_expanded_pub_city_name(SALT30.StrType s0) := MakeFT_invalid_postal_city_name(s0);
EXPORT InValid_expanded_pub_city_name(SALT30.StrType s) := InValidFT_invalid_postal_city_name(s);
EXPORT InValidMessage_expanded_pub_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_postal_city_name(wh);
EXPORT Make_postal_city_name(SALT30.StrType s0) := MakeFT_invalid_postal_city_name(s0);
EXPORT InValid_postal_city_name(SALT30.StrType s) := InValidFT_invalid_postal_city_name(s);
EXPORT InValidMessage_postal_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_postal_city_name(wh);
EXPORT Make_state(SALT30.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_state(SALT30.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
EXPORT Make_z5(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_z5(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_z5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_plus4(SALT30.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_plus4(SALT30.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_plus4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
EXPORT Make_delivery_point_code(SALT30.StrType s0) := MakeFT_invalid_delivery_point_code(s0);
EXPORT InValid_delivery_point_code(SALT30.StrType s) := InValidFT_invalid_delivery_point_code(s);
EXPORT InValidMessage_delivery_point_code(UNSIGNED1 wh) := InValidMessageFT_invalid_delivery_point_code(wh);
EXPORT Make_carrier_route(SALT30.StrType s0) := MakeFT_invalid_carrier_route(s0);
EXPORT InValid_carrier_route(SALT30.StrType s) := InValidFT_invalid_carrier_route(s);
EXPORT InValidMessage_carrier_route(UNSIGNED1 wh) := InValidMessageFT_invalid_carrier_route(wh);
EXPORT Make_county_code_(SALT30.StrType s0) := MakeFT_invalid_county_code_(s0);
EXPORT InValid_county_code_(SALT30.StrType s) := InValidFT_invalid_county_code_(s);
EXPORT InValidMessage_county_code_(UNSIGNED1 wh) := InValidMessageFT_invalid_county_code_(wh);
EXPORT Make_gnrl_address_return_code(SALT30.StrType s0) := MakeFT_invalid_gnrl_address_return_code(s0);
EXPORT InValid_gnrl_address_return_code(SALT30.StrType s) := InValidFT_invalid_gnrl_address_return_code(s);
EXPORT InValidMessage_gnrl_address_return_code(UNSIGNED1 wh) := InValidMessageFT_invalid_gnrl_address_return_code(wh);
EXPORT Make_house_number_usage_flag(SALT30.StrType s0) := MakeFT_invalid_address_flag(s0);
EXPORT InValid_house_number_usage_flag(SALT30.StrType s) := InValidFT_invalid_address_flag(s);
EXPORT InValidMessage_house_number_usage_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_address_flag(wh);
EXPORT Make_pre_direction_usage_flag(SALT30.StrType s0) := MakeFT_invalid_address_flag(s0);
EXPORT InValid_pre_direction_usage_flag(SALT30.StrType s) := InValidFT_invalid_address_flag(s);
EXPORT InValidMessage_pre_direction_usage_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_address_flag(wh);
EXPORT Make_street_name_usage_flag(SALT30.StrType s0) := MakeFT_invalid_address_flag(s0);
EXPORT InValid_street_name_usage_flag(SALT30.StrType s) := InValidFT_invalid_address_flag(s);
EXPORT InValidMessage_street_name_usage_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_address_flag(wh);
EXPORT Make_street_type_usage_flag(SALT30.StrType s0) := MakeFT_invalid_address_flag(s0);
EXPORT InValid_street_type_usage_flag(SALT30.StrType s) := InValidFT_invalid_address_flag(s);
EXPORT InValidMessage_street_type_usage_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_address_flag(wh);
EXPORT Make_post_direction_usage_flag(SALT30.StrType s0) := MakeFT_invalid_address_flag(s0);
EXPORT InValid_post_direction_usage_flag(SALT30.StrType s) := InValidFT_invalid_address_flag(s);
EXPORT InValidMessage_post_direction_usage_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_address_flag(wh);
EXPORT Make_apt_number_usage_flag(SALT30.StrType s0) := MakeFT_invalid_address_flag(s0);
EXPORT InValid_apt_number_usage_flag(SALT30.StrType s) := InValidFT_invalid_address_flag(s);
EXPORT InValidMessage_apt_number_usage_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_address_flag(wh);
EXPORT Make_validation_date(SALT30.StrType s0) := MakeFT_invalid_longdate(s0);
EXPORT InValid_validation_date(SALT30.StrType s) := InValidFT_invalid_longdate(s);
EXPORT InValidMessage_validation_date(UNSIGNED1 wh) := InValidMessageFT_invalid_longdate(wh);
EXPORT Make_validation_flag(SALT30.StrType s0) := MakeFT_invalid_validation_flag(s0);
EXPORT InValid_validation_flag(SALT30.StrType s) := InValidFT_invalid_validation_flag(s);
EXPORT InValidMessage_validation_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_validation_flag(wh);
EXPORT Make_filler1(SALT30.StrType s0) := s0;
EXPORT InValid_filler1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_filler1(UNSIGNED1 wh) := '';
EXPORT Make_dt_first_seen(SALT30.StrType s0) := MakeFT_invalid_shortdate(s0);
EXPORT InValid_dt_first_seen(SALT30.StrType s) := InValidFT_invalid_shortdate(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_shortdate(wh);
EXPORT Make_dt_last_seen(SALT30.StrType s0) := MakeFT_invalid_shortdate(s0);
EXPORT InValid_dt_last_seen(SALT30.StrType s) := InValidFT_invalid_shortdate(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_shortdate(wh);
EXPORT Make_dt_vendor_last_reported(SALT30.StrType s0) := MakeFT_invalid_shortdate(s0);
EXPORT InValid_dt_vendor_last_reported(SALT30.StrType s) := InValidFT_invalid_shortdate(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_shortdate(wh);
EXPORT Make_dt_vendor_first_reported(SALT30.StrType s0) := MakeFT_invalid_shortdate(s0);
EXPORT InValid_dt_vendor_first_reported(SALT30.StrType s) := InValidFT_invalid_shortdate(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_shortdate(wh);
EXPORT Make_rec_type(SALT30.StrType s0) := MakeFT_invalid_rec_type(s0);
EXPORT InValid_rec_type(SALT30.StrType s) := InValidFT_invalid_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_rec_type(wh);
EXPORT Make_hhid(SALT30.StrType s0) := s0;
EXPORT InValid_hhid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_hhid(UNSIGNED1 wh) := '';
EXPORT Make_did(SALT30.StrType s0) := s0;
EXPORT InValid_did(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
EXPORT Make_did_score(SALT30.StrType s0) := s0;
EXPORT InValid_did_score(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
EXPORT Make_fname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_minit(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_minit(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_minit(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_lname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_suffix(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_suffix(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_prim_range(SALT30.StrType s0) := MakeFT_invalid_prim_range(s0);
EXPORT InValid_prim_range(SALT30.StrType s) := InValidFT_invalid_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_prim_range(wh);
EXPORT Make_predir(SALT30.StrType s0) := MakeFT_invalid_predir(s0);
EXPORT InValid_predir(SALT30.StrType s) := InValidFT_invalid_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_predir(wh);
EXPORT Make_prim_name(SALT30.StrType s0) := MakeFT_invalid_prim_name(s0);
EXPORT InValid_prim_name(SALT30.StrType s) := InValidFT_invalid_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_prim_name(wh);
EXPORT Make_suffix(SALT30.StrType s0) := MakeFT_invalid_suffix(s0);
EXPORT InValid_suffix(SALT30.StrType s) := InValidFT_invalid_suffix(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_suffix(wh);
EXPORT Make_postdir(SALT30.StrType s0) := MakeFT_invalid_postdir(s0);
EXPORT InValid_postdir(SALT30.StrType s) := InValidFT_invalid_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_postdir(wh);
EXPORT Make_unit_desig(SALT30.StrType s0) := MakeFT_invalid_unit_desig(s0);
EXPORT InValid_unit_desig(SALT30.StrType s) := InValidFT_invalid_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_invalid_unit_desig(wh);
EXPORT Make_sec_range(SALT30.StrType s0) := MakeFT_invalid_sec_range(s0);
EXPORT InValid_sec_range(SALT30.StrType s) := InValidFT_invalid_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_invalid_sec_range(wh);
EXPORT Make_city_name(SALT30.StrType s0) := MakeFT_invalid_city_name(s0);
EXPORT InValid_city_name(SALT30.StrType s) := InValidFT_invalid_city_name(s);
EXPORT InValidMessage_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_city_name(wh);
EXPORT Make_st(SALT30.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_st(SALT30.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
EXPORT Make_zip(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_zip4(SALT30.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT30.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
EXPORT Make_county(SALT30.StrType s0) := MakeFT_invalid_county(s0);
EXPORT InValid_county(SALT30.StrType s) := InValidFT_invalid_county(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_county(wh);
EXPORT Make_cbsa(SALT30.StrType s0) := MakeFT_invalid_cbsa(s0);
EXPORT InValid_cbsa(SALT30.StrType s) := InValidFT_invalid_cbsa(s);
EXPORT InValidMessage_cbsa(UNSIGNED1 wh) := InValidMessageFT_invalid_cbsa(wh);
EXPORT Make_geo_blk(SALT30.StrType s0) := MakeFT_invalid_geo_blk(s0);
EXPORT InValid_geo_blk(SALT30.StrType s) := InValidFT_invalid_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_blk(wh);
EXPORT Make_cleanname(SALT30.StrType s0) := MakeFT_invalid_raw_name(s0);
EXPORT InValid_cleanname(SALT30.StrType s) := InValidFT_invalid_raw_name(s);
EXPORT InValidMessage_cleanname(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_name(wh);
EXPORT Make_cleanaddress(SALT30.StrType s0) := MakeFT_invalid_cleanaddress(s0);
EXPORT InValid_cleanaddress(SALT30.StrType s) := InValidFT_invalid_cleanaddress(s);
EXPORT InValidMessage_cleanaddress(UNSIGNED1 wh) := InValidMessageFT_invalid_cleanaddress(wh);
EXPORT Make_active(SALT30.StrType s0) := s0;
EXPORT InValid_active(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_active(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_Targus;
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
    BOOLEAN Diff_pubdate;
    BOOLEAN Diff_filler;
    BOOLEAN Diff_yppa_code;
    BOOLEAN Diff_book_code;
    BOOLEAN Diff_page_number;
    BOOLEAN Diff_record_number;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_phone_type;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_no_solicitation_code;
    BOOLEAN Diff_title;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_last_name_suffix;
    BOOLEAN Diff_job_title;
    BOOLEAN Diff_secondary_name_title;
    BOOLEAN Diff_secondary_first_name;
    BOOLEAN Diff_secondary_middle_name;
    BOOLEAN Diff_secondary_name_suffix;
    BOOLEAN Diff_house_number;
    BOOLEAN Diff_pre_direction;
    BOOLEAN Diff_street_name;
    BOOLEAN Diff_street_type;
    BOOLEAN Diff_post_direction;
    BOOLEAN Diff_apt_type;
    BOOLEAN Diff_apt_number;
    BOOLEAN Diff_box_number;
    BOOLEAN Diff_expanded_pub_city_name;
    BOOLEAN Diff_postal_city_name;
    BOOLEAN Diff_state;
    BOOLEAN Diff_z5;
    BOOLEAN Diff_plus4;
    BOOLEAN Diff_delivery_point_code;
    BOOLEAN Diff_carrier_route;
    BOOLEAN Diff_county_code_;
    BOOLEAN Diff_gnrl_address_return_code;
    BOOLEAN Diff_house_number_usage_flag;
    BOOLEAN Diff_pre_direction_usage_flag;
    BOOLEAN Diff_street_name_usage_flag;
    BOOLEAN Diff_street_type_usage_flag;
    BOOLEAN Diff_post_direction_usage_flag;
    BOOLEAN Diff_apt_number_usage_flag;
    BOOLEAN Diff_validation_date;
    BOOLEAN Diff_validation_flag;
    BOOLEAN Diff_filler1;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_hhid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_minit;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_county;
    BOOLEAN Diff_cbsa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_cleanname;
    BOOLEAN Diff_cleanaddress;
    BOOLEAN Diff_active;
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_pubdate := le.pubdate <> ri.pubdate;
    SELF.Diff_filler := le.filler <> ri.filler;
    SELF.Diff_yppa_code := le.yppa_code <> ri.yppa_code;
    SELF.Diff_book_code := le.book_code <> ri.book_code;
    SELF.Diff_page_number := le.page_number <> ri.page_number;
    SELF.Diff_record_number := le.record_number <> ri.record_number;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_no_solicitation_code := le.no_solicitation_code <> ri.no_solicitation_code;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_last_name_suffix := le.last_name_suffix <> ri.last_name_suffix;
    SELF.Diff_job_title := le.job_title <> ri.job_title;
    SELF.Diff_secondary_name_title := le.secondary_name_title <> ri.secondary_name_title;
    SELF.Diff_secondary_first_name := le.secondary_first_name <> ri.secondary_first_name;
    SELF.Diff_secondary_middle_name := le.secondary_middle_name <> ri.secondary_middle_name;
    SELF.Diff_secondary_name_suffix := le.secondary_name_suffix <> ri.secondary_name_suffix;
    SELF.Diff_house_number := le.house_number <> ri.house_number;
    SELF.Diff_pre_direction := le.pre_direction <> ri.pre_direction;
    SELF.Diff_street_name := le.street_name <> ri.street_name;
    SELF.Diff_street_type := le.street_type <> ri.street_type;
    SELF.Diff_post_direction := le.post_direction <> ri.post_direction;
    SELF.Diff_apt_type := le.apt_type <> ri.apt_type;
    SELF.Diff_apt_number := le.apt_number <> ri.apt_number;
    SELF.Diff_box_number := le.box_number <> ri.box_number;
    SELF.Diff_expanded_pub_city_name := le.expanded_pub_city_name <> ri.expanded_pub_city_name;
    SELF.Diff_postal_city_name := le.postal_city_name <> ri.postal_city_name;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_z5 := le.z5 <> ri.z5;
    SELF.Diff_plus4 := le.plus4 <> ri.plus4;
    SELF.Diff_delivery_point_code := le.delivery_point_code <> ri.delivery_point_code;
    SELF.Diff_carrier_route := le.carrier_route <> ri.carrier_route;
    SELF.Diff_county_code_ := le.county_code_ <> ri.county_code_;
    SELF.Diff_gnrl_address_return_code := le.gnrl_address_return_code <> ri.gnrl_address_return_code;
    SELF.Diff_house_number_usage_flag := le.house_number_usage_flag <> ri.house_number_usage_flag;
    SELF.Diff_pre_direction_usage_flag := le.pre_direction_usage_flag <> ri.pre_direction_usage_flag;
    SELF.Diff_street_name_usage_flag := le.street_name_usage_flag <> ri.street_name_usage_flag;
    SELF.Diff_street_type_usage_flag := le.street_type_usage_flag <> ri.street_type_usage_flag;
    SELF.Diff_post_direction_usage_flag := le.post_direction_usage_flag <> ri.post_direction_usage_flag;
    SELF.Diff_apt_number_usage_flag := le.apt_number_usage_flag <> ri.apt_number_usage_flag;
    SELF.Diff_validation_date := le.validation_date <> ri.validation_date;
    SELF.Diff_validation_flag := le.validation_flag <> ri.validation_flag;
    SELF.Diff_filler1 := le.filler1 <> ri.filler1;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_hhid := le.hhid <> ri.hhid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_minit := le.minit <> ri.minit;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_city_name := le.city_name <> ri.city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_cbsa := le.cbsa <> ri.cbsa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_cleanname := le.cleanname <> ri.cleanname;
    SELF.Diff_cleanaddress := le.cleanaddress <> ri.cleanaddress;
    SELF.Diff_active := le.active <> ri.active;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_pubdate,1,0)+ IF( SELF.Diff_filler,1,0)+ IF( SELF.Diff_yppa_code,1,0)+ IF( SELF.Diff_book_code,1,0)+ IF( SELF.Diff_page_number,1,0)+ IF( SELF.Diff_record_number,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_phone_type,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_no_solicitation_code,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_last_name_suffix,1,0)+ IF( SELF.Diff_job_title,1,0)+ IF( SELF.Diff_secondary_name_title,1,0)+ IF( SELF.Diff_secondary_first_name,1,0)+ IF( SELF.Diff_secondary_middle_name,1,0)+ IF( SELF.Diff_secondary_name_suffix,1,0)+ IF( SELF.Diff_house_number,1,0)+ IF( SELF.Diff_pre_direction,1,0)+ IF( SELF.Diff_street_name,1,0)+ IF( SELF.Diff_street_type,1,0)+ IF( SELF.Diff_post_direction,1,0)+ IF( SELF.Diff_apt_type,1,0)+ IF( SELF.Diff_apt_number,1,0)+ IF( SELF.Diff_box_number,1,0)+ IF( SELF.Diff_expanded_pub_city_name,1,0)+ IF( SELF.Diff_postal_city_name,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_z5,1,0)+ IF( SELF.Diff_plus4,1,0)+ IF( SELF.Diff_delivery_point_code,1,0)+ IF( SELF.Diff_carrier_route,1,0)+ IF( SELF.Diff_county_code_,1,0)+ IF( SELF.Diff_gnrl_address_return_code,1,0)+ IF( SELF.Diff_house_number_usage_flag,1,0)+ IF( SELF.Diff_pre_direction_usage_flag,1,0)+ IF( SELF.Diff_street_name_usage_flag,1,0)+ IF( SELF.Diff_street_type_usage_flag,1,0)+ IF( SELF.Diff_post_direction_usage_flag,1,0)+ IF( SELF.Diff_apt_number_usage_flag,1,0)+ IF( SELF.Diff_validation_date,1,0)+ IF( SELF.Diff_validation_flag,1,0)+ IF( SELF.Diff_filler1,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_hhid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_minit,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_cbsa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_cleanname,1,0)+ IF( SELF.Diff_cleanaddress,1,0)+ IF( SELF.Diff_active,1,0);
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
    Count_Diff_pubdate := COUNT(GROUP,%Closest%.Diff_pubdate);
    Count_Diff_filler := COUNT(GROUP,%Closest%.Diff_filler);
    Count_Diff_yppa_code := COUNT(GROUP,%Closest%.Diff_yppa_code);
    Count_Diff_book_code := COUNT(GROUP,%Closest%.Diff_book_code);
    Count_Diff_page_number := COUNT(GROUP,%Closest%.Diff_page_number);
    Count_Diff_record_number := COUNT(GROUP,%Closest%.Diff_record_number);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_no_solicitation_code := COUNT(GROUP,%Closest%.Diff_no_solicitation_code);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_last_name_suffix := COUNT(GROUP,%Closest%.Diff_last_name_suffix);
    Count_Diff_job_title := COUNT(GROUP,%Closest%.Diff_job_title);
    Count_Diff_secondary_name_title := COUNT(GROUP,%Closest%.Diff_secondary_name_title);
    Count_Diff_secondary_first_name := COUNT(GROUP,%Closest%.Diff_secondary_first_name);
    Count_Diff_secondary_middle_name := COUNT(GROUP,%Closest%.Diff_secondary_middle_name);
    Count_Diff_secondary_name_suffix := COUNT(GROUP,%Closest%.Diff_secondary_name_suffix);
    Count_Diff_house_number := COUNT(GROUP,%Closest%.Diff_house_number);
    Count_Diff_pre_direction := COUNT(GROUP,%Closest%.Diff_pre_direction);
    Count_Diff_street_name := COUNT(GROUP,%Closest%.Diff_street_name);
    Count_Diff_street_type := COUNT(GROUP,%Closest%.Diff_street_type);
    Count_Diff_post_direction := COUNT(GROUP,%Closest%.Diff_post_direction);
    Count_Diff_apt_type := COUNT(GROUP,%Closest%.Diff_apt_type);
    Count_Diff_apt_number := COUNT(GROUP,%Closest%.Diff_apt_number);
    Count_Diff_box_number := COUNT(GROUP,%Closest%.Diff_box_number);
    Count_Diff_expanded_pub_city_name := COUNT(GROUP,%Closest%.Diff_expanded_pub_city_name);
    Count_Diff_postal_city_name := COUNT(GROUP,%Closest%.Diff_postal_city_name);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_z5 := COUNT(GROUP,%Closest%.Diff_z5);
    Count_Diff_plus4 := COUNT(GROUP,%Closest%.Diff_plus4);
    Count_Diff_delivery_point_code := COUNT(GROUP,%Closest%.Diff_delivery_point_code);
    Count_Diff_carrier_route := COUNT(GROUP,%Closest%.Diff_carrier_route);
    Count_Diff_county_code_ := COUNT(GROUP,%Closest%.Diff_county_code_);
    Count_Diff_gnrl_address_return_code := COUNT(GROUP,%Closest%.Diff_gnrl_address_return_code);
    Count_Diff_house_number_usage_flag := COUNT(GROUP,%Closest%.Diff_house_number_usage_flag);
    Count_Diff_pre_direction_usage_flag := COUNT(GROUP,%Closest%.Diff_pre_direction_usage_flag);
    Count_Diff_street_name_usage_flag := COUNT(GROUP,%Closest%.Diff_street_name_usage_flag);
    Count_Diff_street_type_usage_flag := COUNT(GROUP,%Closest%.Diff_street_type_usage_flag);
    Count_Diff_post_direction_usage_flag := COUNT(GROUP,%Closest%.Diff_post_direction_usage_flag);
    Count_Diff_apt_number_usage_flag := COUNT(GROUP,%Closest%.Diff_apt_number_usage_flag);
    Count_Diff_validation_date := COUNT(GROUP,%Closest%.Diff_validation_date);
    Count_Diff_validation_flag := COUNT(GROUP,%Closest%.Diff_validation_flag);
    Count_Diff_filler1 := COUNT(GROUP,%Closest%.Diff_filler1);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_hhid := COUNT(GROUP,%Closest%.Diff_hhid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_minit := COUNT(GROUP,%Closest%.Diff_minit);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_city_name := COUNT(GROUP,%Closest%.Diff_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_cbsa := COUNT(GROUP,%Closest%.Diff_cbsa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_cleanname := COUNT(GROUP,%Closest%.Diff_cleanname);
    Count_Diff_cleanaddress := COUNT(GROUP,%Closest%.Diff_cleanaddress);
    Count_Diff_active := COUNT(GROUP,%Closest%.Diff_active);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
