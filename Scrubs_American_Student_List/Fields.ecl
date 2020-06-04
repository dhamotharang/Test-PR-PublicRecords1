IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 90;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_nums','invalid_gender','invalid_gender_code','invalid_alpha','invalid_address','invalid_csz','invalid_county_name','invalid_zip','invalid_date','invalid_suffix','invalid_college_class','invalid_college_code','invalid_code_code_exploded','invalid_college_type_exploded','invalid_address_type','invalid_college_type','invalid_income_lvl_code','invalid_new_income_lvl_code','invalid_income');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_nums' => 1,'invalid_gender' => 2,'invalid_gender_code' => 3,'invalid_alpha' => 4,'invalid_address' => 5,'invalid_csz' => 6,'invalid_county_name' => 7,'invalid_zip' => 8,'invalid_date' => 9,'invalid_suffix' => 10,'invalid_college_class' => 11,'invalid_college_code' => 12,'invalid_code_code_exploded' => 13,'invalid_college_type_exploded' => 14,'invalid_address_type' => 15,'invalid_college_type' => 16,'invalid_income_lvl_code' => 17,'invalid_new_income_lvl_code' => 18,'invalid_income' => 19,0);
 
EXPORT MakeFT_invalid_nums(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_nums(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_nums(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['MALE','FEMALE','']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('MALE|FEMALE|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2','']);
EXPORT InValidMessageFT_invalid_gender_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- '))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_csz(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ,-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_csz(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ,-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_csz(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ,-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_county_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_county_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 3 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 4 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 5));
EXPORT InValidMessageFT_invalid_county_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'),SALT311.HygieneErrors.NotWords('1,2,3,4,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,5,9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_suffix(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_suffix(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),((SALT311.StrType) s) NOT IN ['SR','JR','I','II','III','IV','V','VI','VII','VIII','IX','X','']);
EXPORT InValidMessageFT_invalid_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT311.HygieneErrors.NotInEnum('SR|JR|I|II|III|IV|V|VI|VII|VIII|IX|X|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_college_class(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_college_class(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['FR','GR','JR','SO','SR','UN','']);
EXPORT InValidMessageFT_invalid_college_class(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('FR|GR|JR|SO|SR|UN|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_college_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_college_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2','4','']);
EXPORT InValidMessageFT_invalid_college_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|4|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_code_code_exploded(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_code_code_exploded(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['FOUR YEAR COLLEGE','GRADUATE SCHOOL','TWO YEAR COLLEGE','UNDERGRADUATE SCHOOL','']);
EXPORT InValidMessageFT_invalid_code_code_exploded(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('FOUR YEAR COLLEGE|GRADUATE SCHOOL|TWO YEAR COLLEGE|UNDERGRADUATE SCHOOL|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_college_type_exploded(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_college_type_exploded(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['CHURCH/RELIGIOUS SCHOOL','PRIVATE SCHOOL','PUBLIC/STATE SCHOOL','']);
EXPORT InValidMessageFT_invalid_college_type_exploded(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('CHURCH/RELIGIOUS SCHOOL|PRIVATE SCHOOL|PUBLIC/STATE SCHOOL|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['GENERAL DELIVERY','HIGH-RISE DWELLING','POST OFFICE BOX','RURAL ROUTE','SINGLE FAMILY DWELLING','']);
EXPORT InValidMessageFT_invalid_address_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('GENERAL DELIVERY|HIGH-RISE DWELLING|POST OFFICE BOX|RURAL ROUTE|SINGLE FAMILY DWELLING|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_college_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_college_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N','P','R','S','']);
EXPORT InValidMessageFT_invalid_college_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N|P|R|S|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_income_lvl_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_income_lvl_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','B','C','D','E','F','G','H','I','J','K','T','']);
EXPORT InValidMessageFT_invalid_income_lvl_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|B|C|D|E|F|G|H|I|J|K|T|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_new_income_lvl_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_new_income_lvl_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','B','C','D','E','F','G','H','I','J','K','T','L','M','N','O','']);
EXPORT InValidMessageFT_invalid_new_income_lvl_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|B|C|D|E|F|G|H|I|J|K|T|L|M|N|O|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_income(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'$,+-0123456789OVER '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_income(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'$,+-0123456789OVER '))));
EXPORT InValidMessageFT_invalid_income(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('$,+-0123456789OVER '),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'key','ssn','did','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','historical_flag','full_name','first_name','last_name','address_1','address_2','city','state','zip','zip_4','crrt_code','delivery_point_barcode','zip4_check_digit','address_type_code','address_type','county_number','county_name','gender_code','gender','age','birth_date','dob_formatted','telephone','class','college_class','college_name','ln_college_name','college_major','new_college_major','college_code','college_code_exploded','college_type','college_type_exploded','head_of_household_first_name','head_of_household_gender_code','head_of_household_gender','income_level_code','income_level','new_income_level_code','new_income_level','file_type','tier','school_size_code','competitive_code','tuition_code','title','fname','mname','lname','name_suffix','name_score','rawaid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','county','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','tier2','source');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'key','ssn','did','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','historical_flag','full_name','first_name','last_name','address_1','address_2','city','state','zip','zip_4','crrt_code','delivery_point_barcode','zip4_check_digit','address_type_code','address_type','county_number','county_name','gender_code','gender','age','birth_date','dob_formatted','telephone','class','college_class','college_name','ln_college_name','college_major','new_college_major','college_code','college_code_exploded','college_type','college_type_exploded','head_of_household_first_name','head_of_household_gender_code','head_of_household_gender','income_level_code','income_level','new_income_level_code','new_income_level','file_type','tier','school_size_code','competitive_code','tuition_code','title','fname','mname','lname','name_suffix','name_score','rawaid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','county','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','tier2','source');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'key' => 0,'ssn' => 1,'did' => 2,'process_date' => 3,'date_first_seen' => 4,'date_last_seen' => 5,'date_vendor_first_reported' => 6,'date_vendor_last_reported' => 7,'historical_flag' => 8,'full_name' => 9,'first_name' => 10,'last_name' => 11,'address_1' => 12,'address_2' => 13,'city' => 14,'state' => 15,'zip' => 16,'zip_4' => 17,'crrt_code' => 18,'delivery_point_barcode' => 19,'zip4_check_digit' => 20,'address_type_code' => 21,'address_type' => 22,'county_number' => 23,'county_name' => 24,'gender_code' => 25,'gender' => 26,'age' => 27,'birth_date' => 28,'dob_formatted' => 29,'telephone' => 30,'class' => 31,'college_class' => 32,'college_name' => 33,'ln_college_name' => 34,'college_major' => 35,'new_college_major' => 36,'college_code' => 37,'college_code_exploded' => 38,'college_type' => 39,'college_type_exploded' => 40,'head_of_household_first_name' => 41,'head_of_household_gender_code' => 42,'head_of_household_gender' => 43,'income_level_code' => 44,'income_level' => 45,'new_income_level_code' => 46,'new_income_level' => 47,'file_type' => 48,'tier' => 49,'school_size_code' => 50,'competitive_code' => 51,'tuition_code' => 52,'title' => 53,'fname' => 54,'mname' => 55,'lname' => 56,'name_suffix' => 57,'name_score' => 58,'rawaid' => 59,'prim_range' => 60,'predir' => 61,'prim_name' => 62,'addr_suffix' => 63,'postdir' => 64,'unit_desig' => 65,'sec_range' => 66,'p_city_name' => 67,'v_city_name' => 68,'st' => 69,'z5' => 70,'zip4' => 71,'cart' => 72,'cr_sort_sz' => 73,'lot' => 74,'lot_order' => 75,'dpbc' => 76,'chk_digit' => 77,'rec_type' => 78,'county' => 79,'ace_fips_st' => 80,'fips_county' => 81,'geo_lat' => 82,'geo_long' => 83,'msa' => 84,'geo_blk' => 85,'geo_match' => 86,'err_stat' => 87,'tier2' => 88,'source' => 89,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],['ALLOW'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW','LENGTHS'],[],[],[],[],[],['ENUM'],['ALLOW'],['ALLOW','WORDS'],['ENUM'],['ENUM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],[],['ENUM'],[],[],[],[],['ENUM'],['ENUM'],['ENUM'],['ENUM'],[],['ENUM'],['ENUM'],['ENUM'],[],['ENUM'],[],[],[],[],[],[],[],[],[],[],['ALLOW','ENUM'],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_key(SALT311.StrType s0) := s0;
EXPORT InValid_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_key(UNSIGNED1 wh) := '';
 
EXPORT Make_ssn(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_ssn(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
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
 
EXPORT Make_historical_flag(SALT311.StrType s0) := s0;
EXPORT InValid_historical_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_historical_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_full_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_full_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_full_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_first_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_first_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_last_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_last_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_address_1(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_1(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_address_2(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_2(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_state(SALT311.StrType s0) := s0;
EXPORT InValid_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_zip_4(SALT311.StrType s0) := s0;
EXPORT InValid_zip_4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip_4(UNSIGNED1 wh) := '';
 
EXPORT Make_crrt_code(SALT311.StrType s0) := s0;
EXPORT InValid_crrt_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_crrt_code(UNSIGNED1 wh) := '';
 
EXPORT Make_delivery_point_barcode(SALT311.StrType s0) := s0;
EXPORT InValid_delivery_point_barcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_delivery_point_barcode(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4_check_digit(SALT311.StrType s0) := s0;
EXPORT InValid_zip4_check_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4_check_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_address_type_code(SALT311.StrType s0) := s0;
EXPORT InValid_address_type_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_address_type_code(UNSIGNED1 wh) := '';
 
EXPORT Make_address_type(SALT311.StrType s0) := MakeFT_invalid_address_type(s0);
EXPORT InValid_address_type(SALT311.StrType s) := InValidFT_invalid_address_type(s);
EXPORT InValidMessage_address_type(UNSIGNED1 wh) := InValidMessageFT_invalid_address_type(wh);
 
EXPORT Make_county_number(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_county_number(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_county_number(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_county_name(SALT311.StrType s0) := MakeFT_invalid_county_name(s0);
EXPORT InValid_county_name(SALT311.StrType s) := InValidFT_invalid_county_name(s);
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := InValidMessageFT_invalid_county_name(wh);
 
EXPORT Make_gender_code(SALT311.StrType s0) := MakeFT_invalid_gender_code(s0);
EXPORT InValid_gender_code(SALT311.StrType s) := InValidFT_invalid_gender_code(s);
EXPORT InValidMessage_gender_code(UNSIGNED1 wh) := InValidMessageFT_invalid_gender_code(wh);
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_age(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_age(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_age(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_birth_date(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_birth_date(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_birth_date(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_dob_formatted(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_formatted(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_formatted(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_telephone(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_telephone(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_telephone(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_class(SALT311.StrType s0) := s0;
EXPORT InValid_class(SALT311.StrType s) := 0;
EXPORT InValidMessage_class(UNSIGNED1 wh) := '';
 
EXPORT Make_college_class(SALT311.StrType s0) := MakeFT_invalid_college_class(s0);
EXPORT InValid_college_class(SALT311.StrType s) := InValidFT_invalid_college_class(s);
EXPORT InValidMessage_college_class(UNSIGNED1 wh) := InValidMessageFT_invalid_college_class(wh);
 
EXPORT Make_college_name(SALT311.StrType s0) := s0;
EXPORT InValid_college_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_college_name(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_college_name(SALT311.StrType s0) := s0;
EXPORT InValid_ln_college_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_college_name(UNSIGNED1 wh) := '';
 
EXPORT Make_college_major(SALT311.StrType s0) := s0;
EXPORT InValid_college_major(SALT311.StrType s) := 0;
EXPORT InValidMessage_college_major(UNSIGNED1 wh) := '';
 
EXPORT Make_new_college_major(SALT311.StrType s0) := s0;
EXPORT InValid_new_college_major(SALT311.StrType s) := 0;
EXPORT InValidMessage_new_college_major(UNSIGNED1 wh) := '';
 
EXPORT Make_college_code(SALT311.StrType s0) := MakeFT_invalid_college_code(s0);
EXPORT InValid_college_code(SALT311.StrType s) := InValidFT_invalid_college_code(s);
EXPORT InValidMessage_college_code(UNSIGNED1 wh) := InValidMessageFT_invalid_college_code(wh);
 
EXPORT Make_college_code_exploded(SALT311.StrType s0) := MakeFT_invalid_code_code_exploded(s0);
EXPORT InValid_college_code_exploded(SALT311.StrType s) := InValidFT_invalid_code_code_exploded(s);
EXPORT InValidMessage_college_code_exploded(UNSIGNED1 wh) := InValidMessageFT_invalid_code_code_exploded(wh);
 
EXPORT Make_college_type(SALT311.StrType s0) := MakeFT_invalid_college_type(s0);
EXPORT InValid_college_type(SALT311.StrType s) := InValidFT_invalid_college_type(s);
EXPORT InValidMessage_college_type(UNSIGNED1 wh) := InValidMessageFT_invalid_college_type(wh);
 
EXPORT Make_college_type_exploded(SALT311.StrType s0) := MakeFT_invalid_college_type_exploded(s0);
EXPORT InValid_college_type_exploded(SALT311.StrType s) := InValidFT_invalid_college_type_exploded(s);
EXPORT InValidMessage_college_type_exploded(UNSIGNED1 wh) := InValidMessageFT_invalid_college_type_exploded(wh);
 
EXPORT Make_head_of_household_first_name(SALT311.StrType s0) := s0;
EXPORT InValid_head_of_household_first_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_head_of_household_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_head_of_household_gender_code(SALT311.StrType s0) := MakeFT_invalid_gender_code(s0);
EXPORT InValid_head_of_household_gender_code(SALT311.StrType s) := InValidFT_invalid_gender_code(s);
EXPORT InValidMessage_head_of_household_gender_code(UNSIGNED1 wh) := InValidMessageFT_invalid_gender_code(wh);
 
EXPORT Make_head_of_household_gender(SALT311.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_head_of_household_gender(SALT311.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_head_of_household_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_income_level_code(SALT311.StrType s0) := MakeFT_invalid_income_lvl_code(s0);
EXPORT InValid_income_level_code(SALT311.StrType s) := InValidFT_invalid_income_lvl_code(s);
EXPORT InValidMessage_income_level_code(UNSIGNED1 wh) := InValidMessageFT_invalid_income_lvl_code(wh);
 
EXPORT Make_income_level(SALT311.StrType s0) := s0;
EXPORT InValid_income_level(SALT311.StrType s) := 0;
EXPORT InValidMessage_income_level(UNSIGNED1 wh) := '';
 
EXPORT Make_new_income_level_code(SALT311.StrType s0) := MakeFT_invalid_new_income_lvl_code(s0);
EXPORT InValid_new_income_level_code(SALT311.StrType s) := InValidFT_invalid_new_income_lvl_code(s);
EXPORT InValidMessage_new_income_level_code(UNSIGNED1 wh) := InValidMessageFT_invalid_new_income_lvl_code(wh);
 
EXPORT Make_new_income_level(SALT311.StrType s0) := s0;
EXPORT InValid_new_income_level(SALT311.StrType s) := 0;
EXPORT InValidMessage_new_income_level(UNSIGNED1 wh) := '';
 
EXPORT Make_file_type(SALT311.StrType s0) := s0;
EXPORT InValid_file_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_file_type(UNSIGNED1 wh) := '';
 
EXPORT Make_tier(SALT311.StrType s0) := s0;
EXPORT InValid_tier(SALT311.StrType s) := 0;
EXPORT InValidMessage_tier(UNSIGNED1 wh) := '';
 
EXPORT Make_school_size_code(SALT311.StrType s0) := s0;
EXPORT InValid_school_size_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_school_size_code(UNSIGNED1 wh) := '';
 
EXPORT Make_competitive_code(SALT311.StrType s0) := s0;
EXPORT InValid_competitive_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_competitive_code(UNSIGNED1 wh) := '';
 
EXPORT Make_tuition_code(SALT311.StrType s0) := s0;
EXPORT InValid_tuition_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_tuition_code(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT311.StrType s0) := s0;
EXPORT InValid_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT311.StrType s0) := s0;
EXPORT InValid_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT311.StrType s0) := s0;
EXPORT InValid_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT311.StrType s0) := s0;
EXPORT InValid_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT311.StrType s0) := MakeFT_invalid_suffix(s0);
EXPORT InValid_name_suffix(SALT311.StrType s) := InValidFT_invalid_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_suffix(wh);
 
EXPORT Make_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_rawaid(SALT311.StrType s0) := s0;
EXPORT InValid_rawaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_suffix(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_invalid_csz(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_invalid_csz(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_csz(wh);
 
EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_invalid_csz(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_invalid_csz(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_csz(wh);
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_z5(SALT311.StrType s0) := s0;
EXPORT InValid_z5(SALT311.StrType s) := 0;
EXPORT InValidMessage_z5(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_county(SALT311.StrType s0) := s0;
EXPORT InValid_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT311.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_county(SALT311.StrType s0) := s0;
EXPORT InValid_fips_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_tier2(SALT311.StrType s0) := s0;
EXPORT InValid_tier2(SALT311.StrType s) := 0;
EXPORT InValidMessage_tier2(UNSIGNED1 wh) := '';
 
EXPORT Make_source(SALT311.StrType s0) := s0;
EXPORT InValid_source(SALT311.StrType s) := 0;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_American_Student_List;
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
    BOOLEAN Diff_key;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_did;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_historical_flag;
    BOOLEAN Diff_full_name;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_address_1;
    BOOLEAN Diff_address_2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip_4;
    BOOLEAN Diff_crrt_code;
    BOOLEAN Diff_delivery_point_barcode;
    BOOLEAN Diff_zip4_check_digit;
    BOOLEAN Diff_address_type_code;
    BOOLEAN Diff_address_type;
    BOOLEAN Diff_county_number;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_gender_code;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_age;
    BOOLEAN Diff_birth_date;
    BOOLEAN Diff_dob_formatted;
    BOOLEAN Diff_telephone;
    BOOLEAN Diff_class;
    BOOLEAN Diff_college_class;
    BOOLEAN Diff_college_name;
    BOOLEAN Diff_ln_college_name;
    BOOLEAN Diff_college_major;
    BOOLEAN Diff_new_college_major;
    BOOLEAN Diff_college_code;
    BOOLEAN Diff_college_code_exploded;
    BOOLEAN Diff_college_type;
    BOOLEAN Diff_college_type_exploded;
    BOOLEAN Diff_head_of_household_first_name;
    BOOLEAN Diff_head_of_household_gender_code;
    BOOLEAN Diff_head_of_household_gender;
    BOOLEAN Diff_income_level_code;
    BOOLEAN Diff_income_level;
    BOOLEAN Diff_new_income_level_code;
    BOOLEAN Diff_new_income_level;
    BOOLEAN Diff_file_type;
    BOOLEAN Diff_tier;
    BOOLEAN Diff_school_size_code;
    BOOLEAN Diff_competitive_code;
    BOOLEAN Diff_tuition_code;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_rawaid;
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
    BOOLEAN Diff_z5;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_county;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_tier2;
    BOOLEAN Diff_source;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_key := le.key <> ri.key;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_historical_flag := le.historical_flag <> ri.historical_flag;
    SELF.Diff_full_name := le.full_name <> ri.full_name;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_address_1 := le.address_1 <> ri.address_1;
    SELF.Diff_address_2 := le.address_2 <> ri.address_2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip_4 := le.zip_4 <> ri.zip_4;
    SELF.Diff_crrt_code := le.crrt_code <> ri.crrt_code;
    SELF.Diff_delivery_point_barcode := le.delivery_point_barcode <> ri.delivery_point_barcode;
    SELF.Diff_zip4_check_digit := le.zip4_check_digit <> ri.zip4_check_digit;
    SELF.Diff_address_type_code := le.address_type_code <> ri.address_type_code;
    SELF.Diff_address_type := le.address_type <> ri.address_type;
    SELF.Diff_county_number := le.county_number <> ri.county_number;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_gender_code := le.gender_code <> ri.gender_code;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_age := le.age <> ri.age;
    SELF.Diff_birth_date := le.birth_date <> ri.birth_date;
    SELF.Diff_dob_formatted := le.dob_formatted <> ri.dob_formatted;
    SELF.Diff_telephone := le.telephone <> ri.telephone;
    SELF.Diff_class := le.class <> ri.class;
    SELF.Diff_college_class := le.college_class <> ri.college_class;
    SELF.Diff_college_name := le.college_name <> ri.college_name;
    SELF.Diff_ln_college_name := le.ln_college_name <> ri.ln_college_name;
    SELF.Diff_college_major := le.college_major <> ri.college_major;
    SELF.Diff_new_college_major := le.new_college_major <> ri.new_college_major;
    SELF.Diff_college_code := le.college_code <> ri.college_code;
    SELF.Diff_college_code_exploded := le.college_code_exploded <> ri.college_code_exploded;
    SELF.Diff_college_type := le.college_type <> ri.college_type;
    SELF.Diff_college_type_exploded := le.college_type_exploded <> ri.college_type_exploded;
    SELF.Diff_head_of_household_first_name := le.head_of_household_first_name <> ri.head_of_household_first_name;
    SELF.Diff_head_of_household_gender_code := le.head_of_household_gender_code <> ri.head_of_household_gender_code;
    SELF.Diff_head_of_household_gender := le.head_of_household_gender <> ri.head_of_household_gender;
    SELF.Diff_income_level_code := le.income_level_code <> ri.income_level_code;
    SELF.Diff_income_level := le.income_level <> ri.income_level;
    SELF.Diff_new_income_level_code := le.new_income_level_code <> ri.new_income_level_code;
    SELF.Diff_new_income_level := le.new_income_level <> ri.new_income_level;
    SELF.Diff_file_type := le.file_type <> ri.file_type;
    SELF.Diff_tier := le.tier <> ri.tier;
    SELF.Diff_school_size_code := le.school_size_code <> ri.school_size_code;
    SELF.Diff_competitive_code := le.competitive_code <> ri.competitive_code;
    SELF.Diff_tuition_code := le.tuition_code <> ri.tuition_code;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
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
    SELF.Diff_z5 := le.z5 <> ri.z5;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_tier2 := le.tier2 <> ri.tier2;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_key,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_historical_flag,1,0)+ IF( SELF.Diff_full_name,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_address_1,1,0)+ IF( SELF.Diff_address_2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip_4,1,0)+ IF( SELF.Diff_crrt_code,1,0)+ IF( SELF.Diff_delivery_point_barcode,1,0)+ IF( SELF.Diff_zip4_check_digit,1,0)+ IF( SELF.Diff_address_type_code,1,0)+ IF( SELF.Diff_address_type,1,0)+ IF( SELF.Diff_county_number,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_gender_code,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_birth_date,1,0)+ IF( SELF.Diff_dob_formatted,1,0)+ IF( SELF.Diff_telephone,1,0)+ IF( SELF.Diff_class,1,0)+ IF( SELF.Diff_college_class,1,0)+ IF( SELF.Diff_college_name,1,0)+ IF( SELF.Diff_ln_college_name,1,0)+ IF( SELF.Diff_college_major,1,0)+ IF( SELF.Diff_new_college_major,1,0)+ IF( SELF.Diff_college_code,1,0)+ IF( SELF.Diff_college_code_exploded,1,0)+ IF( SELF.Diff_college_type,1,0)+ IF( SELF.Diff_college_type_exploded,1,0)+ IF( SELF.Diff_head_of_household_first_name,1,0)+ IF( SELF.Diff_head_of_household_gender_code,1,0)+ IF( SELF.Diff_head_of_household_gender,1,0)+ IF( SELF.Diff_income_level_code,1,0)+ IF( SELF.Diff_income_level,1,0)+ IF( SELF.Diff_new_income_level_code,1,0)+ IF( SELF.Diff_new_income_level,1,0)+ IF( SELF.Diff_file_type,1,0)+ IF( SELF.Diff_tier,1,0)+ IF( SELF.Diff_school_size_code,1,0)+ IF( SELF.Diff_competitive_code,1,0)+ IF( SELF.Diff_tuition_code,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_z5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_tier2,1,0)+ IF( SELF.Diff_source,1,0);
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
    Count_Diff_key := COUNT(GROUP,%Closest%.Diff_key);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_historical_flag := COUNT(GROUP,%Closest%.Diff_historical_flag);
    Count_Diff_full_name := COUNT(GROUP,%Closest%.Diff_full_name);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_address_1 := COUNT(GROUP,%Closest%.Diff_address_1);
    Count_Diff_address_2 := COUNT(GROUP,%Closest%.Diff_address_2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip_4 := COUNT(GROUP,%Closest%.Diff_zip_4);
    Count_Diff_crrt_code := COUNT(GROUP,%Closest%.Diff_crrt_code);
    Count_Diff_delivery_point_barcode := COUNT(GROUP,%Closest%.Diff_delivery_point_barcode);
    Count_Diff_zip4_check_digit := COUNT(GROUP,%Closest%.Diff_zip4_check_digit);
    Count_Diff_address_type_code := COUNT(GROUP,%Closest%.Diff_address_type_code);
    Count_Diff_address_type := COUNT(GROUP,%Closest%.Diff_address_type);
    Count_Diff_county_number := COUNT(GROUP,%Closest%.Diff_county_number);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_gender_code := COUNT(GROUP,%Closest%.Diff_gender_code);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_age := COUNT(GROUP,%Closest%.Diff_age);
    Count_Diff_birth_date := COUNT(GROUP,%Closest%.Diff_birth_date);
    Count_Diff_dob_formatted := COUNT(GROUP,%Closest%.Diff_dob_formatted);
    Count_Diff_telephone := COUNT(GROUP,%Closest%.Diff_telephone);
    Count_Diff_class := COUNT(GROUP,%Closest%.Diff_class);
    Count_Diff_college_class := COUNT(GROUP,%Closest%.Diff_college_class);
    Count_Diff_college_name := COUNT(GROUP,%Closest%.Diff_college_name);
    Count_Diff_ln_college_name := COUNT(GROUP,%Closest%.Diff_ln_college_name);
    Count_Diff_college_major := COUNT(GROUP,%Closest%.Diff_college_major);
    Count_Diff_new_college_major := COUNT(GROUP,%Closest%.Diff_new_college_major);
    Count_Diff_college_code := COUNT(GROUP,%Closest%.Diff_college_code);
    Count_Diff_college_code_exploded := COUNT(GROUP,%Closest%.Diff_college_code_exploded);
    Count_Diff_college_type := COUNT(GROUP,%Closest%.Diff_college_type);
    Count_Diff_college_type_exploded := COUNT(GROUP,%Closest%.Diff_college_type_exploded);
    Count_Diff_head_of_household_first_name := COUNT(GROUP,%Closest%.Diff_head_of_household_first_name);
    Count_Diff_head_of_household_gender_code := COUNT(GROUP,%Closest%.Diff_head_of_household_gender_code);
    Count_Diff_head_of_household_gender := COUNT(GROUP,%Closest%.Diff_head_of_household_gender);
    Count_Diff_income_level_code := COUNT(GROUP,%Closest%.Diff_income_level_code);
    Count_Diff_income_level := COUNT(GROUP,%Closest%.Diff_income_level);
    Count_Diff_new_income_level_code := COUNT(GROUP,%Closest%.Diff_new_income_level_code);
    Count_Diff_new_income_level := COUNT(GROUP,%Closest%.Diff_new_income_level);
    Count_Diff_file_type := COUNT(GROUP,%Closest%.Diff_file_type);
    Count_Diff_tier := COUNT(GROUP,%Closest%.Diff_tier);
    Count_Diff_school_size_code := COUNT(GROUP,%Closest%.Diff_school_size_code);
    Count_Diff_competitive_code := COUNT(GROUP,%Closest%.Diff_competitive_code);
    Count_Diff_tuition_code := COUNT(GROUP,%Closest%.Diff_tuition_code);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
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
    Count_Diff_z5 := COUNT(GROUP,%Closest%.Diff_z5);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_tier2 := COUNT(GROUP,%Closest%.Diff_tier2);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
