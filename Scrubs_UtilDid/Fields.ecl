IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alphanum','invalid_alpha','invalid_ssn','invalid_phone','invalid_address','invalid_name','invalid_zip','invalid_date','invalid_addr_type','invalid_num','invalid_addrdual','invalid_utiltype');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_alphanum' => 1,'invalid_alpha' => 2,'invalid_ssn' => 3,'invalid_phone' => 4,'invalid_address' => 5,'invalid_name' => 6,'invalid_zip' => 7,'invalid_date' => 8,'invalid_addr_type' => 9,'invalid_num' => 10,'invalid_addrdual' => 11,'invalid_utiltype' => 12,0);
EXPORT MakeFT_invalid_alphanum(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_;,"*'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanum(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_;,"*'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alphanum(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_;,"*'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_ssn(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ssn(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,4,9'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_phone(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,10'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_address(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -/#.\'&'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_address(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -/#.\'&'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -/#.\'&'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789-'),SALT30.HygieneErrors.NotLength('0,4,5,9,10'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,6,8'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_addr_type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'SB'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addr_type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'SB'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_addr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('SB'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_num(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_num(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_num(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_addrdual(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'FYN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addrdual(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'FYN'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_addrdual(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('FYN'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_utiltype(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'123'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_utiltype(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'123'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_utiltype(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('123'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'id','exchange_serial_number','date_added_to_exchange','connect_date','date_first_seen','record_date','util_type','orig_lname','orig_fname','orig_mname','orig_name_suffix','addr_type','addr_dual','address_street','address_street_Name','address_street_type','address_street_direction','address_apartment','address_city','address_state','address_zip','ssn','work_phone','phone','dob','drivers_license_state_code','drivers_license','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','did','title','fname','mname','lname','name_suffix','name_score','fdid','hhid');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'id' => 1,'exchange_serial_number' => 2,'date_added_to_exchange' => 3,'connect_date' => 4,'date_first_seen' => 5,'record_date' => 6,'util_type' => 7,'orig_lname' => 8,'orig_fname' => 9,'orig_mname' => 10,'orig_name_suffix' => 11,'addr_type' => 12,'addr_dual' => 13,'address_street' => 14,'address_street_Name' => 15,'address_street_type' => 16,'address_street_direction' => 17,'address_apartment' => 18,'address_city' => 19,'address_state' => 20,'address_zip' => 21,'ssn' => 22,'work_phone' => 23,'phone' => 24,'dob' => 25,'drivers_license_state_code' => 26,'drivers_license' => 27,'prim_range' => 28,'predir' => 29,'prim_name' => 30,'addr_suffix' => 31,'postdir' => 32,'unit_desig' => 33,'sec_range' => 34,'p_city_name' => 35,'v_city_name' => 36,'st' => 37,'zip' => 38,'zip4' => 39,'cart' => 40,'cr_sort_sz' => 41,'lot' => 42,'lot_order' => 43,'dbpc' => 44,'chk_digit' => 45,'rec_type' => 46,'county' => 47,'geo_lat' => 48,'geo_long' => 49,'msa' => 50,'geo_blk' => 51,'geo_match' => 52,'err_stat' => 53,'did' => 54,'title' => 55,'fname' => 56,'mname' => 57,'lname' => 58,'name_suffix' => 59,'name_score' => 60,'fdid' => 61,'hhid' => 62,0);
//Individual field level validation
EXPORT Make_id(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_id(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_id(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_exchange_serial_number(SALT30.StrType s0) := MakeFT_invalid_num(s0);
EXPORT InValid_exchange_serial_number(SALT30.StrType s) := InValidFT_invalid_num(s);
EXPORT InValidMessage_exchange_serial_number(UNSIGNED1 wh) := InValidMessageFT_invalid_num(wh);
EXPORT Make_date_added_to_exchange(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_added_to_exchange(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_added_to_exchange(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_connect_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_connect_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_connect_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_first_seen(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_first_seen(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_record_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_record_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_record_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_util_type(SALT30.StrType s0) := MakeFT_invalid_utiltype(s0);
EXPORT InValid_util_type(SALT30.StrType s) := InValidFT_invalid_utiltype(s);
EXPORT InValidMessage_util_type(UNSIGNED1 wh) := InValidMessageFT_invalid_utiltype(wh);
EXPORT Make_orig_lname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_lname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_orig_fname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_fname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_orig_mname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_mname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_orig_name_suffix(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_orig_name_suffix(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_orig_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_addr_type(SALT30.StrType s0) := MakeFT_invalid_addr_type(s0);
EXPORT InValid_addr_type(SALT30.StrType s) := InValidFT_invalid_addr_type(s);
EXPORT InValidMessage_addr_type(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_type(wh);
EXPORT Make_addr_dual(SALT30.StrType s0) := MakeFT_invalid_addrdual(s0);
EXPORT InValid_addr_dual(SALT30.StrType s) := InValidFT_invalid_addrdual(s);
EXPORT InValidMessage_addr_dual(UNSIGNED1 wh) := InValidMessageFT_invalid_addrdual(wh);
EXPORT Make_address_street(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_street(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_street(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_address_street_Name(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_street_Name(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_street_Name(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_address_street_type(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_street_type(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_street_type(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_address_street_direction(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_street_direction(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_street_direction(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_address_apartment(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_apartment(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_apartment(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_address_city(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_city(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_city(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_address_state(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_address_state(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_address_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_address_zip(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_address_zip(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_address_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_ssn(SALT30.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_ssn(SALT30.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
EXPORT Make_work_phone(SALT30.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_work_phone(SALT30.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_work_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
EXPORT Make_phone(SALT30.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT30.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
EXPORT Make_dob(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_drivers_license_state_code(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_drivers_license_state_code(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_drivers_license_state_code(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_drivers_license(SALT30.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_drivers_license(SALT30.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_drivers_license(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
EXPORT Make_prim_range(SALT30.StrType s0) := s0;
EXPORT InValid_prim_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
EXPORT Make_predir(SALT30.StrType s0) := s0;
EXPORT InValid_predir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
EXPORT Make_prim_name(SALT30.StrType s0) := s0;
EXPORT InValid_prim_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
EXPORT Make_addr_suffix(SALT30.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
EXPORT Make_postdir(SALT30.StrType s0) := s0;
EXPORT InValid_postdir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
EXPORT Make_unit_desig(SALT30.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
EXPORT Make_sec_range(SALT30.StrType s0) := s0;
EXPORT InValid_sec_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
EXPORT Make_p_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
EXPORT Make_v_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
EXPORT Make_st(SALT30.StrType s0) := s0;
EXPORT InValid_st(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
EXPORT Make_zip(SALT30.StrType s0) := s0;
EXPORT InValid_zip(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
EXPORT Make_zip4(SALT30.StrType s0) := s0;
EXPORT InValid_zip4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
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
EXPORT Make_did(SALT30.StrType s0) := s0;
EXPORT InValid_did(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
EXPORT Make_title(SALT30.StrType s0) := s0;
EXPORT InValid_title(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
EXPORT Make_fname(SALT30.StrType s0) := s0;
EXPORT InValid_fname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
EXPORT Make_mname(SALT30.StrType s0) := s0;
EXPORT InValid_mname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
EXPORT Make_lname(SALT30.StrType s0) := s0;
EXPORT InValid_lname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
EXPORT Make_name_suffix(SALT30.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
EXPORT Make_name_score(SALT30.StrType s0) := s0;
EXPORT InValid_name_score(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
EXPORT Make_fdid(SALT30.StrType s0) := s0;
EXPORT InValid_fdid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_fdid(UNSIGNED1 wh) := '';
EXPORT Make_hhid(SALT30.StrType s0) := s0;
EXPORT InValid_hhid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_hhid(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_UtilDid;
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
    BOOLEAN Diff_id;
    BOOLEAN Diff_exchange_serial_number;
    BOOLEAN Diff_date_added_to_exchange;
    BOOLEAN Diff_connect_date;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_record_date;
    BOOLEAN Diff_util_type;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_mname;
    BOOLEAN Diff_orig_name_suffix;
    BOOLEAN Diff_addr_type;
    BOOLEAN Diff_addr_dual;
    BOOLEAN Diff_address_street;
    BOOLEAN Diff_address_street_Name;
    BOOLEAN Diff_address_street_type;
    BOOLEAN Diff_address_street_direction;
    BOOLEAN Diff_address_apartment;
    BOOLEAN Diff_address_city;
    BOOLEAN Diff_address_state;
    BOOLEAN Diff_address_zip;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_work_phone;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_drivers_license_state_code;
    BOOLEAN Diff_drivers_license;
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
    BOOLEAN Diff_did;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_fdid;
    BOOLEAN Diff_hhid;
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_id := le.id <> ri.id;
    SELF.Diff_exchange_serial_number := le.exchange_serial_number <> ri.exchange_serial_number;
    SELF.Diff_date_added_to_exchange := le.date_added_to_exchange <> ri.date_added_to_exchange;
    SELF.Diff_connect_date := le.connect_date <> ri.connect_date;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_record_date := le.record_date <> ri.record_date;
    SELF.Diff_util_type := le.util_type <> ri.util_type;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_mname := le.orig_mname <> ri.orig_mname;
    SELF.Diff_orig_name_suffix := le.orig_name_suffix <> ri.orig_name_suffix;
    SELF.Diff_addr_type := le.addr_type <> ri.addr_type;
    SELF.Diff_addr_dual := le.addr_dual <> ri.addr_dual;
    SELF.Diff_address_street := le.address_street <> ri.address_street;
    SELF.Diff_address_street_Name := le.address_street_Name <> ri.address_street_Name;
    SELF.Diff_address_street_type := le.address_street_type <> ri.address_street_type;
    SELF.Diff_address_street_direction := le.address_street_direction <> ri.address_street_direction;
    SELF.Diff_address_apartment := le.address_apartment <> ri.address_apartment;
    SELF.Diff_address_city := le.address_city <> ri.address_city;
    SELF.Diff_address_state := le.address_state <> ri.address_state;
    SELF.Diff_address_zip := le.address_zip <> ri.address_zip;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_work_phone := le.work_phone <> ri.work_phone;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_drivers_license_state_code := le.drivers_license_state_code <> ri.drivers_license_state_code;
    SELF.Diff_drivers_license := le.drivers_license <> ri.drivers_license;
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
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_fdid := le.fdid <> ri.fdid;
    SELF.Diff_hhid := le.hhid <> ri.hhid;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_id,1,0)+ IF( SELF.Diff_exchange_serial_number,1,0)+ IF( SELF.Diff_date_added_to_exchange,1,0)+ IF( SELF.Diff_connect_date,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_record_date,1,0)+ IF( SELF.Diff_util_type,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_name_suffix,1,0)+ IF( SELF.Diff_addr_type,1,0)+ IF( SELF.Diff_addr_dual,1,0)+ IF( SELF.Diff_address_street,1,0)+ IF( SELF.Diff_address_street_Name,1,0)+ IF( SELF.Diff_address_street_type,1,0)+ IF( SELF.Diff_address_street_direction,1,0)+ IF( SELF.Diff_address_apartment,1,0)+ IF( SELF.Diff_address_city,1,0)+ IF( SELF.Diff_address_state,1,0)+ IF( SELF.Diff_address_zip,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_work_phone,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_drivers_license_state_code,1,0)+ IF( SELF.Diff_drivers_license,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_fdid,1,0)+ IF( SELF.Diff_hhid,1,0);
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
    Count_Diff_id := COUNT(GROUP,%Closest%.Diff_id);
    Count_Diff_exchange_serial_number := COUNT(GROUP,%Closest%.Diff_exchange_serial_number);
    Count_Diff_date_added_to_exchange := COUNT(GROUP,%Closest%.Diff_date_added_to_exchange);
    Count_Diff_connect_date := COUNT(GROUP,%Closest%.Diff_connect_date);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_record_date := COUNT(GROUP,%Closest%.Diff_record_date);
    Count_Diff_util_type := COUNT(GROUP,%Closest%.Diff_util_type);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_mname := COUNT(GROUP,%Closest%.Diff_orig_mname);
    Count_Diff_orig_name_suffix := COUNT(GROUP,%Closest%.Diff_orig_name_suffix);
    Count_Diff_addr_type := COUNT(GROUP,%Closest%.Diff_addr_type);
    Count_Diff_addr_dual := COUNT(GROUP,%Closest%.Diff_addr_dual);
    Count_Diff_address_street := COUNT(GROUP,%Closest%.Diff_address_street);
    Count_Diff_address_street_Name := COUNT(GROUP,%Closest%.Diff_address_street_Name);
    Count_Diff_address_street_type := COUNT(GROUP,%Closest%.Diff_address_street_type);
    Count_Diff_address_street_direction := COUNT(GROUP,%Closest%.Diff_address_street_direction);
    Count_Diff_address_apartment := COUNT(GROUP,%Closest%.Diff_address_apartment);
    Count_Diff_address_city := COUNT(GROUP,%Closest%.Diff_address_city);
    Count_Diff_address_state := COUNT(GROUP,%Closest%.Diff_address_state);
    Count_Diff_address_zip := COUNT(GROUP,%Closest%.Diff_address_zip);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_work_phone := COUNT(GROUP,%Closest%.Diff_work_phone);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_drivers_license_state_code := COUNT(GROUP,%Closest%.Diff_drivers_license_state_code);
    Count_Diff_drivers_license := COUNT(GROUP,%Closest%.Diff_drivers_license);
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
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_fdid := COUNT(GROUP,%Closest%.Diff_fdid);
    Count_Diff_hhid := COUNT(GROUP,%Closest%.Diff_hhid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
