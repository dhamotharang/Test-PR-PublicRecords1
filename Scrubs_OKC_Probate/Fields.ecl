IMPORT SALT38;
EXPORT Fields := MODULE

EXPORT NumFields := 85;

// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'nums','lowercase','uppercase','alphas','lowercaseandnums','uppercaseandnums','alphasandnums','allupper','allupperandnums','allalphaandnums','blank','invalid_blank','invalid_alpha','invalid_Num','invalid_date','invalid_name','invalid_company','invalid_address','invalid_city','invalid_state','invalid_zip','invalid_phone','invalid_casenumber','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'nums' => 1,'lowercase' => 2,'uppercase' => 3,'alphas' => 4,'lowercaseandnums' => 5,'uppercaseandnums' => 6,'alphasandnums' => 7,'allupper' => 8,'allupperandnums' => 9,'allalphaandnums' => 10,'blank' => 11,'invalid_blank' => 12,'invalid_alpha' => 13,'invalid_Num' => 14,'invalid_date' => 15,'invalid_name' => 16,'invalid_company' => 17,'invalid_address' => 18,'invalid_city' => 19,'invalid_state' => 20,'invalid_zip' => 21,'invalid_phone' => 22,'invalid_casenumber' => 23,'predir' => 24,'prim_name' => 25,'addr_suffix' => 26,'postdir' => 27,'unit_desig' => 28,'sec_range' => 29,'p_city_name' => 30,'v_city_name' => 31,'st' => 32,'zip' => 33,'zip4' => 34,'cart' => 35,'cr_sort_sz' => 36,'lot' => 37,'lot_order' => 38,'dbpc' => 39,'chk_digit' => 40,'rec_type' => 41,'fips_county' => 42,'geo_lat' => 43,'geo_long' => 44,'msa' => 45,'geo_blk' => 46,'geo_match' => 47,'err_stat' => 48,'rawaid' => 49,0);

EXPORT MakeFT_nums(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_nums(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_nums(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_lowercase(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_lowercase(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_lowercase(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyz'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_uppercase(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_uppercase(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_uppercase(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_alphas(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alphas(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_alphas(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_lowercaseandnums(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'abcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_lowercaseandnums(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'abcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_lowercaseandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyz0123456789'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_uppercaseandnums(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_uppercaseandnums(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_uppercaseandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_alphasandnums(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alphasandnums(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_alphasandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_allupper(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_allupper(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_allupper(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_allupperandnums(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_allupperandnums(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_allupperandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_allalphaandnums(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_allalphaandnums(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_allalphaandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_blank(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_blank(SALT38.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotLength('0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_blank(SALT38.StrType s0) := FUNCTION
  RETURN  MakeFT_blank(s0);
END;
EXPORT InValidFT_invalid_blank(SALT38.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotLength('0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_alpha(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alpha(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_date(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 -/'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_nums(s2);
END;
EXPORT InValidFT_invalid_date(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 -/'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 -/'),SALT38.HygieneErrors.NotLength('0,8,9,10'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_name(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -,./\''); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -,./\'',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allupperandnums(s2);
END;
EXPORT InValidFT_invalid_name(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -,./\''))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -,./\''),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_company(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,&\\/.:#;()"'); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,' -,&\\/.:#;()"',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_company(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,&\\/.:#;()"'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_company(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,&\\/.:#;()"'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_address(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -&/\\#%.;,\''); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,' -&/\\#%.;,\'',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allupperandnums(s3);
END;
EXPORT InValidFT_invalid_address(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -&/\\#%.;,\''))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -&/\\#%.;,\''),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_city(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -,&\\/.:#;()"'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -,&\\/.:#;()"',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_city(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -,&\\/.:#;()"'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -,&\\/.:#;()"'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_state(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_uppercase(s1);
END;
EXPORT InValidFT_invalid_state(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.NotLength('0,2'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_zip(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 -'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_nums(s2);
END;
EXPORT InValidFT_invalid_zip(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 -'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 -'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_phone(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 ()-+'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ()-+',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_nums(s2);
END;
EXPORT InValidFT_invalid_phone(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 ()-+'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 15));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 ()-+'),SALT38.HygieneErrors.NotLength('0..15'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_invalid_casenumber(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 +.-'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' +.-',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_alphasandnums(s2);
END;
EXPORT InValidFT_invalid_casenumber(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 +.-'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_casenumber(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 +.-'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_predir(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_predir(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ENSW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ENSW '),SALT38.HygieneErrors.NotLength('0,1,2'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_prim_name(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /-'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' /-',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_prim_name(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /-'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 /-'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_addr_suffix(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_addr_suffix(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT38.HygieneErrors.NotLength('2,3,0,4'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_postdir(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_postdir(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ENSW '))));
EXPORT InValidMessageFT_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ENSW '),SALT38.HygieneErrors.Good);

EXPORT MakeFT_unit_desig(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ #'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' #',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_unit_desig(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ #'))));
EXPORT InValidMessageFT_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ #'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_sec_range(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_sec_range(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_p_city_name(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_p_city_name(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_v_city_name(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_v_city_name(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_st(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_st(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_st(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT38.HygieneErrors.NotLength('0,2'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_zip(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_zip(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.NotLength('5,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_zip4(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_zip4(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.NotLength('4,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_cart(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789BCHR '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_cart(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789BCHR '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789BCHR '),SALT38.HygieneErrors.NotLength('4,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_cr_sort_sz(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'BCD '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_cr_sort_sz(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'BCD '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('BCD '),SALT38.HygieneErrors.NotLength('0,1'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_lot(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_lot(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.NotLength('4,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_lot_order(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'AD '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_lot_order(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'AD '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('AD '),SALT38.HygieneErrors.NotLength('1,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_dbpc(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_dbpc(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.NotLength('2,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_chk_digit(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_chk_digit(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.NotLength('0,1'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_rec_type(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'DFHMPRS '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_rec_type(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'DFHMPRS '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('DFHMPRS '),SALT38.HygieneErrors.NotLength('0,1,2'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_fips_county(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_fips_county(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.NotLength('3,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_geo_lat(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 .'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' .',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_geo_lat(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 .'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_geo_lat(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 .'),SALT38.HygieneErrors.NotLength('9,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_geo_long(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 -.'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -.',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_geo_long(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 -.'))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_geo_long(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 -.'),SALT38.HygieneErrors.NotLength('10,11,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_msa(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_msa(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.NotLength('4,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_geo_blk(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_geo_blk(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.NotLength('7,0'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_geo_match(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0145 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_geo_match(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0145 '))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0145 '),SALT38.HygieneErrors.NotLength('1'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_err_stat(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789ABCDEFS '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_err_stat(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789ABCDEFS '))),~(LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789ABCDEFS '),SALT38.HygieneErrors.NotLength('4'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_rawaid(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_Num(s2);
END;
EXPORT InValidFT_rawaid(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 13));
EXPORT InValidMessageFT_rawaid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.NotLength('1,13'),SALT38.HygieneErrors.Good);


EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'name_score','filedate','dod','dob','masterid','debtorfirstname','debtorlastname','debtoraddress1','debtoraddress2','debtoraddresscity','debtoraddressstate','debtoraddresszipcode','dateofdeath','dateofbirth','isprobatelocated','casenumber','filingdate','lastdatetofileclaim','issubjecttocreditorsclaim','publicationstartdate','isestateopen','executorfirstname','executorlastname','executoraddress1','executoraddress2','executoraddresscity','executoraddressstate','executoraddresszipcode','executorphone','attorneyfirstname','attorneylastname','firm','attorneyaddress1','attorneyaddress2','attorneyaddresscity','attorneyaddressstate','attorneyaddresszipcode','attorneyphone','attorneyemail','documenttypes','corr_dateofdeath','pdid','pfrd_address_ind','nid','cln_title','cln_fname','cln_mname','cln_lname','cln_suffix','cln_title2','cln_fname2','cln_mname2','cln_lname2','cln_suffix2','persistent_record_id','cname','cleanaid','addresstype','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'name_score','filedate','dod','dob','masterid','debtorfirstname','debtorlastname','debtoraddress1','debtoraddress2','debtoraddresscity','debtoraddressstate','debtoraddresszipcode','dateofdeath','dateofbirth','isprobatelocated','casenumber','filingdate','lastdatetofileclaim','issubjecttocreditorsclaim','publicationstartdate','isestateopen','executorfirstname','executorlastname','executoraddress1','executoraddress2','executoraddresscity','executoraddressstate','executoraddresszipcode','executorphone','attorneyfirstname','attorneylastname','firm','attorneyaddress1','attorneyaddress2','attorneyaddresscity','attorneyaddressstate','attorneyaddresszipcode','attorneyphone','attorneyemail','documenttypes','corr_dateofdeath','pdid','pfrd_address_ind','nid','cln_title','cln_fname','cln_mname','cln_lname','cln_suffix','cln_title2','cln_fname2','cln_mname2','cln_lname2','cln_suffix2','persistent_record_id','cname','cleanaid','addresstype','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'name_score' => 0,'filedate' => 1,'dod' => 2,'dob' => 3,'masterid' => 4,'debtorfirstname' => 5,'debtorlastname' => 6,'debtoraddress1' => 7,'debtoraddress2' => 8,'debtoraddresscity' => 9,'debtoraddressstate' => 10,'debtoraddresszipcode' => 11,'dateofdeath' => 12,'dateofbirth' => 13,'isprobatelocated' => 14,'casenumber' => 15,'filingdate' => 16,'lastdatetofileclaim' => 17,'issubjecttocreditorsclaim' => 18,'publicationstartdate' => 19,'isestateopen' => 20,'executorfirstname' => 21,'executorlastname' => 22,'executoraddress1' => 23,'executoraddress2' => 24,'executoraddresscity' => 25,'executoraddressstate' => 26,'executoraddresszipcode' => 27,'executorphone' => 28,'attorneyfirstname' => 29,'attorneylastname' => 30,'firm' => 31,'attorneyaddress1' => 32,'attorneyaddress2' => 33,'attorneyaddresscity' => 34,'attorneyaddressstate' => 35,'attorneyaddresszipcode' => 36,'attorneyphone' => 37,'attorneyemail' => 38,'documenttypes' => 39,'corr_dateofdeath' => 40,'pdid' => 41,'pfrd_address_ind' => 42,'nid' => 43,'cln_title' => 44,'cln_fname' => 45,'cln_mname' => 46,'cln_lname' => 47,'cln_suffix' => 48,'cln_title2' => 49,'cln_fname2' => 50,'cln_mname2' => 51,'cln_lname2' => 52,'cln_suffix2' => 53,'persistent_record_id' => 54,'cname' => 55,'cleanaid' => 56,'addresstype' => 57,'prim_range' => 58,'predir' => 59,'prim_name' => 60,'addr_suffix' => 61,'postdir' => 62,'unit_desig' => 63,'sec_range' => 64,'p_city_name' => 65,'v_city_name' => 66,'st' => 67,'zip' => 68,'zip4' => 69,'cart' => 70,'cr_sort_sz' => 71,'lot' => 72,'lot_order' => 73,'dbpc' => 74,'chk_digit' => 75,'rec_type' => 76,'fips_county' => 77,'geo_lat' => 78,'geo_long' => 79,'msa' => 80,'geo_blk' => 81,'geo_match' => 82,'err_stat' => 83,'rawaid' => 84,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['CAPS','ALLOW','LENGTH'],['CAPS','ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],['ALLOW','LENGTH'],[],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['CAPS','ALLOW','LENGTH'],['CAPS','ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],['CAPS','ALLOW','LENGTH'],['CAPS','ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],[],[],[],[],[],[],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],['CAPS','ALLOW','LENGTH'],[],[],[],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW'],['ALLOW'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_name_score(SALT38.StrType s0) := MakeFT_invalid_Num(s0);
EXPORT InValid_name_score(SALT38.StrType s) := InValidFT_invalid_Num(s);
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := InValidMessageFT_invalid_Num(wh);


EXPORT Make_filedate(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_filedate(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_filedate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_dod(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dod(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dod(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_dob(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_masterid(SALT38.StrType s0) := MakeFT_alphasandnums(s0);
EXPORT InValid_masterid(SALT38.StrType s) := InValidFT_alphasandnums(s);
EXPORT InValidMessage_masterid(UNSIGNED1 wh) := InValidMessageFT_alphasandnums(wh);


EXPORT Make_debtorfirstname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_debtorfirstname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_debtorfirstname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_debtorlastname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_debtorlastname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_debtorlastname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_debtoraddress1(SALT38.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_debtoraddress1(SALT38.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_debtoraddress1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_debtoraddress2(SALT38.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_debtoraddress2(SALT38.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_debtoraddress2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_debtoraddresscity(SALT38.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_debtoraddresscity(SALT38.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_debtoraddresscity(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);


EXPORT Make_debtoraddressstate(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_debtoraddressstate(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_debtoraddressstate(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_debtoraddresszipcode(SALT38.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_debtoraddresszipcode(SALT38.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_debtoraddresszipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);


EXPORT Make_dateofdeath(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dateofdeath(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dateofdeath(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_dateofbirth(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dateofbirth(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dateofbirth(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_isprobatelocated(SALT38.StrType s0) := s0;
EXPORT InValid_isprobatelocated(SALT38.StrType s) := 0;
EXPORT InValidMessage_isprobatelocated(UNSIGNED1 wh) := '';


EXPORT Make_casenumber(SALT38.StrType s0) := MakeFT_invalid_casenumber(s0);
EXPORT InValid_casenumber(SALT38.StrType s) := InValidFT_invalid_casenumber(s);
EXPORT InValidMessage_casenumber(UNSIGNED1 wh) := InValidMessageFT_invalid_casenumber(wh);


EXPORT Make_filingdate(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_filingdate(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_filingdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_lastdatetofileclaim(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_lastdatetofileclaim(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_lastdatetofileclaim(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_issubjecttocreditorsclaim(SALT38.StrType s0) := s0;
EXPORT InValid_issubjecttocreditorsclaim(SALT38.StrType s) := 0;
EXPORT InValidMessage_issubjecttocreditorsclaim(UNSIGNED1 wh) := '';


EXPORT Make_publicationstartdate(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_publicationstartdate(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_publicationstartdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_isestateopen(SALT38.StrType s0) := s0;
EXPORT InValid_isestateopen(SALT38.StrType s) := 0;
EXPORT InValidMessage_isestateopen(UNSIGNED1 wh) := '';


EXPORT Make_executorfirstname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_executorfirstname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_executorfirstname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_executorlastname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_executorlastname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_executorlastname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_executoraddress1(SALT38.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_executoraddress1(SALT38.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_executoraddress1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_executoraddress2(SALT38.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_executoraddress2(SALT38.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_executoraddress2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_executoraddresscity(SALT38.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_executoraddresscity(SALT38.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_executoraddresscity(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);


EXPORT Make_executoraddressstate(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_executoraddressstate(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_executoraddressstate(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_executoraddresszipcode(SALT38.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_executoraddresszipcode(SALT38.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_executoraddresszipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);


EXPORT Make_executorphone(SALT38.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_executorphone(SALT38.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_executorphone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);


EXPORT Make_attorneyfirstname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_attorneyfirstname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_attorneyfirstname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_attorneylastname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_attorneylastname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_attorneylastname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_firm(SALT38.StrType s0) := s0;
EXPORT InValid_firm(SALT38.StrType s) := 0;
EXPORT InValidMessage_firm(UNSIGNED1 wh) := '';


EXPORT Make_attorneyaddress1(SALT38.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_attorneyaddress1(SALT38.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_attorneyaddress1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_attorneyaddress2(SALT38.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_attorneyaddress2(SALT38.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_attorneyaddress2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_attorneyaddresscity(SALT38.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_attorneyaddresscity(SALT38.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_attorneyaddresscity(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);


EXPORT Make_attorneyaddressstate(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_attorneyaddressstate(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_attorneyaddressstate(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_attorneyaddresszipcode(SALT38.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_attorneyaddresszipcode(SALT38.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_attorneyaddresszipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);


EXPORT Make_attorneyphone(SALT38.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_attorneyphone(SALT38.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_attorneyphone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);


EXPORT Make_attorneyemail(SALT38.StrType s0) := s0;
EXPORT InValid_attorneyemail(SALT38.StrType s) := 0;
EXPORT InValidMessage_attorneyemail(UNSIGNED1 wh) := '';


EXPORT Make_documenttypes(SALT38.StrType s0) := s0;
EXPORT InValid_documenttypes(SALT38.StrType s) := 0;
EXPORT InValidMessage_documenttypes(UNSIGNED1 wh) := '';


EXPORT Make_corr_dateofdeath(SALT38.StrType s0) := s0;
EXPORT InValid_corr_dateofdeath(SALT38.StrType s) := 0;
EXPORT InValidMessage_corr_dateofdeath(UNSIGNED1 wh) := '';


EXPORT Make_pdid(SALT38.StrType s0) := s0;
EXPORT InValid_pdid(SALT38.StrType s) := 0;
EXPORT InValidMessage_pdid(UNSIGNED1 wh) := '';


EXPORT Make_pfrd_address_ind(SALT38.StrType s0) := s0;
EXPORT InValid_pfrd_address_ind(SALT38.StrType s) := 0;
EXPORT InValidMessage_pfrd_address_ind(UNSIGNED1 wh) := '';


EXPORT Make_nid(SALT38.StrType s0) := s0;
EXPORT InValid_nid(SALT38.StrType s) := 0;
EXPORT InValidMessage_nid(UNSIGNED1 wh) := '';


EXPORT Make_cln_title(SALT38.StrType s0) := s0;
EXPORT InValid_cln_title(SALT38.StrType s) := 0;
EXPORT InValidMessage_cln_title(UNSIGNED1 wh) := '';


EXPORT Make_cln_fname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_cln_fname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_cln_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_cln_mname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_cln_mname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_cln_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_cln_lname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_cln_lname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_cln_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_cln_suffix(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_cln_suffix(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_cln_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_cln_title2(SALT38.StrType s0) := s0;
EXPORT InValid_cln_title2(SALT38.StrType s) := 0;
EXPORT InValidMessage_cln_title2(UNSIGNED1 wh) := '';


EXPORT Make_cln_fname2(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_cln_fname2(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_cln_fname2(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_cln_mname2(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_cln_mname2(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_cln_mname2(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_cln_lname2(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_cln_lname2(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_cln_lname2(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_cln_suffix2(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_cln_suffix2(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_cln_suffix2(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_persistent_record_id(SALT38.StrType s0) := s0;
EXPORT InValid_persistent_record_id(SALT38.StrType s) := 0;
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := '';


EXPORT Make_cname(SALT38.StrType s0) := MakeFT_invalid_company(s0);
EXPORT InValid_cname(SALT38.StrType s) := InValidFT_invalid_company(s);
EXPORT InValidMessage_cname(UNSIGNED1 wh) := InValidMessageFT_invalid_company(wh);


EXPORT Make_cleanaid(SALT38.StrType s0) := s0;
EXPORT InValid_cleanaid(SALT38.StrType s) := 0;
EXPORT InValidMessage_cleanaid(UNSIGNED1 wh) := '';


EXPORT Make_addresstype(SALT38.StrType s0) := s0;
EXPORT InValid_addresstype(SALT38.StrType s) := 0;
EXPORT InValidMessage_addresstype(UNSIGNED1 wh) := '';


EXPORT Make_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';


EXPORT Make_predir(SALT38.StrType s0) := MakeFT_predir(s0);
EXPORT InValid_predir(SALT38.StrType s) := InValidFT_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_predir(wh);


EXPORT Make_prim_name(SALT38.StrType s0) := MakeFT_prim_name(s0);
EXPORT InValid_prim_name(SALT38.StrType s) := InValidFT_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_prim_name(wh);


EXPORT Make_addr_suffix(SALT38.StrType s0) := MakeFT_addr_suffix(s0);
EXPORT InValid_addr_suffix(SALT38.StrType s) := InValidFT_addr_suffix(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_addr_suffix(wh);


EXPORT Make_postdir(SALT38.StrType s0) := MakeFT_postdir(s0);
EXPORT InValid_postdir(SALT38.StrType s) := InValidFT_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_postdir(wh);


EXPORT Make_unit_desig(SALT38.StrType s0) := MakeFT_unit_desig(s0);
EXPORT InValid_unit_desig(SALT38.StrType s) := InValidFT_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_unit_desig(wh);


EXPORT Make_sec_range(SALT38.StrType s0) := MakeFT_sec_range(s0);
EXPORT InValid_sec_range(SALT38.StrType s) := InValidFT_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_sec_range(wh);


EXPORT Make_p_city_name(SALT38.StrType s0) := MakeFT_p_city_name(s0);
EXPORT InValid_p_city_name(SALT38.StrType s) := InValidFT_p_city_name(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_p_city_name(wh);


EXPORT Make_v_city_name(SALT38.StrType s0) := MakeFT_v_city_name(s0);
EXPORT InValid_v_city_name(SALT38.StrType s) := InValidFT_v_city_name(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_v_city_name(wh);


EXPORT Make_st(SALT38.StrType s0) := MakeFT_st(s0);
EXPORT InValid_st(SALT38.StrType s) := InValidFT_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_st(wh);


EXPORT Make_zip(SALT38.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT38.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);


EXPORT Make_zip4(SALT38.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT38.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);


EXPORT Make_cart(SALT38.StrType s0) := MakeFT_cart(s0);
EXPORT InValid_cart(SALT38.StrType s) := InValidFT_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_cart(wh);


EXPORT Make_cr_sort_sz(SALT38.StrType s0) := MakeFT_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT38.StrType s) := InValidFT_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_cr_sort_sz(wh);


EXPORT Make_lot(SALT38.StrType s0) := MakeFT_lot(s0);
EXPORT InValid_lot(SALT38.StrType s) := InValidFT_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_lot(wh);


EXPORT Make_lot_order(SALT38.StrType s0) := MakeFT_lot_order(s0);
EXPORT InValid_lot_order(SALT38.StrType s) := InValidFT_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_lot_order(wh);


EXPORT Make_dbpc(SALT38.StrType s0) := MakeFT_dbpc(s0);
EXPORT InValid_dbpc(SALT38.StrType s) := InValidFT_dbpc(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_dbpc(wh);


EXPORT Make_chk_digit(SALT38.StrType s0) := MakeFT_chk_digit(s0);
EXPORT InValid_chk_digit(SALT38.StrType s) := InValidFT_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_chk_digit(wh);


EXPORT Make_rec_type(SALT38.StrType s0) := MakeFT_rec_type(s0);
EXPORT InValid_rec_type(SALT38.StrType s) := InValidFT_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_rec_type(wh);


EXPORT Make_fips_county(SALT38.StrType s0) := MakeFT_fips_county(s0);
EXPORT InValid_fips_county(SALT38.StrType s) := InValidFT_fips_county(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_fips_county(wh);


EXPORT Make_geo_lat(SALT38.StrType s0) := MakeFT_geo_lat(s0);
EXPORT InValid_geo_lat(SALT38.StrType s) := InValidFT_geo_lat(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_geo_lat(wh);


EXPORT Make_geo_long(SALT38.StrType s0) := MakeFT_geo_long(s0);
EXPORT InValid_geo_long(SALT38.StrType s) := InValidFT_geo_long(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_geo_long(wh);


EXPORT Make_msa(SALT38.StrType s0) := MakeFT_msa(s0);
EXPORT InValid_msa(SALT38.StrType s) := InValidFT_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_msa(wh);


EXPORT Make_geo_blk(SALT38.StrType s0) := MakeFT_geo_blk(s0);
EXPORT InValid_geo_blk(SALT38.StrType s) := InValidFT_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_geo_blk(wh);


EXPORT Make_geo_match(SALT38.StrType s0) := MakeFT_geo_match(s0);
EXPORT InValid_geo_match(SALT38.StrType s) := InValidFT_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_geo_match(wh);


EXPORT Make_err_stat(SALT38.StrType s0) := MakeFT_err_stat(s0);
EXPORT InValid_err_stat(SALT38.StrType s) := InValidFT_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_err_stat(wh);


EXPORT Make_rawaid(SALT38.StrType s0) := MakeFT_rawaid(s0);
EXPORT InValid_rawaid(SALT38.StrType s) := InValidFT_rawaid(s);
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := InValidMessageFT_rawaid(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_OKC_Probate;
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
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_filedate;
    BOOLEAN Diff_dod;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_masterid;
    BOOLEAN Diff_debtorfirstname;
    BOOLEAN Diff_debtorlastname;
    BOOLEAN Diff_debtoraddress1;
    BOOLEAN Diff_debtoraddress2;
    BOOLEAN Diff_debtoraddresscity;
    BOOLEAN Diff_debtoraddressstate;
    BOOLEAN Diff_debtoraddresszipcode;
    BOOLEAN Diff_dateofdeath;
    BOOLEAN Diff_dateofbirth;
    BOOLEAN Diff_isprobatelocated;
    BOOLEAN Diff_casenumber;
    BOOLEAN Diff_filingdate;
    BOOLEAN Diff_lastdatetofileclaim;
    BOOLEAN Diff_issubjecttocreditorsclaim;
    BOOLEAN Diff_publicationstartdate;
    BOOLEAN Diff_isestateopen;
    BOOLEAN Diff_executorfirstname;
    BOOLEAN Diff_executorlastname;
    BOOLEAN Diff_executoraddress1;
    BOOLEAN Diff_executoraddress2;
    BOOLEAN Diff_executoraddresscity;
    BOOLEAN Diff_executoraddressstate;
    BOOLEAN Diff_executoraddresszipcode;
    BOOLEAN Diff_executorphone;
    BOOLEAN Diff_attorneyfirstname;
    BOOLEAN Diff_attorneylastname;
    BOOLEAN Diff_firm;
    BOOLEAN Diff_attorneyaddress1;
    BOOLEAN Diff_attorneyaddress2;
    BOOLEAN Diff_attorneyaddresscity;
    BOOLEAN Diff_attorneyaddressstate;
    BOOLEAN Diff_attorneyaddresszipcode;
    BOOLEAN Diff_attorneyphone;
    BOOLEAN Diff_attorneyemail;
    BOOLEAN Diff_documenttypes;
    BOOLEAN Diff_corr_dateofdeath;
    BOOLEAN Diff_pdid;
    BOOLEAN Diff_pfrd_address_ind;
    BOOLEAN Diff_nid;
    BOOLEAN Diff_cln_title;
    BOOLEAN Diff_cln_fname;
    BOOLEAN Diff_cln_mname;
    BOOLEAN Diff_cln_lname;
    BOOLEAN Diff_cln_suffix;
    BOOLEAN Diff_cln_title2;
    BOOLEAN Diff_cln_fname2;
    BOOLEAN Diff_cln_mname2;
    BOOLEAN Diff_cln_lname2;
    BOOLEAN Diff_cln_suffix2;
    BOOLEAN Diff_persistent_record_id;
    BOOLEAN Diff_cname;
    BOOLEAN Diff_cleanaid;
    BOOLEAN Diff_addresstype;
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
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_rawaid;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_filedate := le.filedate <> ri.filedate;
    SELF.Diff_dod := le.dod <> ri.dod;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_masterid := le.masterid <> ri.masterid;
    SELF.Diff_debtorfirstname := le.debtorfirstname <> ri.debtorfirstname;
    SELF.Diff_debtorlastname := le.debtorlastname <> ri.debtorlastname;
    SELF.Diff_debtoraddress1 := le.debtoraddress1 <> ri.debtoraddress1;
    SELF.Diff_debtoraddress2 := le.debtoraddress2 <> ri.debtoraddress2;
    SELF.Diff_debtoraddresscity := le.debtoraddresscity <> ri.debtoraddresscity;
    SELF.Diff_debtoraddressstate := le.debtoraddressstate <> ri.debtoraddressstate;
    SELF.Diff_debtoraddresszipcode := le.debtoraddresszipcode <> ri.debtoraddresszipcode;
    SELF.Diff_dateofdeath := le.dateofdeath <> ri.dateofdeath;
    SELF.Diff_dateofbirth := le.dateofbirth <> ri.dateofbirth;
    SELF.Diff_isprobatelocated := le.isprobatelocated <> ri.isprobatelocated;
    SELF.Diff_casenumber := le.casenumber <> ri.casenumber;
    SELF.Diff_filingdate := le.filingdate <> ri.filingdate;
    SELF.Diff_lastdatetofileclaim := le.lastdatetofileclaim <> ri.lastdatetofileclaim;
    SELF.Diff_issubjecttocreditorsclaim := le.issubjecttocreditorsclaim <> ri.issubjecttocreditorsclaim;
    SELF.Diff_publicationstartdate := le.publicationstartdate <> ri.publicationstartdate;
    SELF.Diff_isestateopen := le.isestateopen <> ri.isestateopen;
    SELF.Diff_executorfirstname := le.executorfirstname <> ri.executorfirstname;
    SELF.Diff_executorlastname := le.executorlastname <> ri.executorlastname;
    SELF.Diff_executoraddress1 := le.executoraddress1 <> ri.executoraddress1;
    SELF.Diff_executoraddress2 := le.executoraddress2 <> ri.executoraddress2;
    SELF.Diff_executoraddresscity := le.executoraddresscity <> ri.executoraddresscity;
    SELF.Diff_executoraddressstate := le.executoraddressstate <> ri.executoraddressstate;
    SELF.Diff_executoraddresszipcode := le.executoraddresszipcode <> ri.executoraddresszipcode;
    SELF.Diff_executorphone := le.executorphone <> ri.executorphone;
    SELF.Diff_attorneyfirstname := le.attorneyfirstname <> ri.attorneyfirstname;
    SELF.Diff_attorneylastname := le.attorneylastname <> ri.attorneylastname;
    SELF.Diff_firm := le.firm <> ri.firm;
    SELF.Diff_attorneyaddress1 := le.attorneyaddress1 <> ri.attorneyaddress1;
    SELF.Diff_attorneyaddress2 := le.attorneyaddress2 <> ri.attorneyaddress2;
    SELF.Diff_attorneyaddresscity := le.attorneyaddresscity <> ri.attorneyaddresscity;
    SELF.Diff_attorneyaddressstate := le.attorneyaddressstate <> ri.attorneyaddressstate;
    SELF.Diff_attorneyaddresszipcode := le.attorneyaddresszipcode <> ri.attorneyaddresszipcode;
    SELF.Diff_attorneyphone := le.attorneyphone <> ri.attorneyphone;
    SELF.Diff_attorneyemail := le.attorneyemail <> ri.attorneyemail;
    SELF.Diff_documenttypes := le.documenttypes <> ri.documenttypes;
    SELF.Diff_corr_dateofdeath := le.corr_dateofdeath <> ri.corr_dateofdeath;
    SELF.Diff_pdid := le.pdid <> ri.pdid;
    SELF.Diff_pfrd_address_ind := le.pfrd_address_ind <> ri.pfrd_address_ind;
    SELF.Diff_nid := le.nid <> ri.nid;
    SELF.Diff_cln_title := le.cln_title <> ri.cln_title;
    SELF.Diff_cln_fname := le.cln_fname <> ri.cln_fname;
    SELF.Diff_cln_mname := le.cln_mname <> ri.cln_mname;
    SELF.Diff_cln_lname := le.cln_lname <> ri.cln_lname;
    SELF.Diff_cln_suffix := le.cln_suffix <> ri.cln_suffix;
    SELF.Diff_cln_title2 := le.cln_title2 <> ri.cln_title2;
    SELF.Diff_cln_fname2 := le.cln_fname2 <> ri.cln_fname2;
    SELF.Diff_cln_mname2 := le.cln_mname2 <> ri.cln_mname2;
    SELF.Diff_cln_lname2 := le.cln_lname2 <> ri.cln_lname2;
    SELF.Diff_cln_suffix2 := le.cln_suffix2 <> ri.cln_suffix2;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Diff_cname := le.cname <> ri.cname;
    SELF.Diff_cleanaid := le.cleanaid <> ri.cleanaid;
    SELF.Diff_addresstype := le.addresstype <> ri.addresstype;
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
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_filedate,1,0)+ IF( SELF.Diff_dod,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_masterid,1,0)+ IF( SELF.Diff_debtorfirstname,1,0)+ IF( SELF.Diff_debtorlastname,1,0)+ IF( SELF.Diff_debtoraddress1,1,0)+ IF( SELF.Diff_debtoraddress2,1,0)+ IF( SELF.Diff_debtoraddresscity,1,0)+ IF( SELF.Diff_debtoraddressstate,1,0)+ IF( SELF.Diff_debtoraddresszipcode,1,0)+ IF( SELF.Diff_dateofdeath,1,0)+ IF( SELF.Diff_dateofbirth,1,0)+ IF( SELF.Diff_isprobatelocated,1,0)+ IF( SELF.Diff_casenumber,1,0)+ IF( SELF.Diff_filingdate,1,0)+ IF( SELF.Diff_lastdatetofileclaim,1,0)+ IF( SELF.Diff_issubjecttocreditorsclaim,1,0)+ IF( SELF.Diff_publicationstartdate,1,0)+ IF( SELF.Diff_isestateopen,1,0)+ IF( SELF.Diff_executorfirstname,1,0)+ IF( SELF.Diff_executorlastname,1,0)+ IF( SELF.Diff_executoraddress1,1,0)+ IF( SELF.Diff_executoraddress2,1,0)+ IF( SELF.Diff_executoraddresscity,1,0)+ IF( SELF.Diff_executoraddressstate,1,0)+ IF( SELF.Diff_executoraddresszipcode,1,0)+ IF( SELF.Diff_executorphone,1,0)+ IF( SELF.Diff_attorneyfirstname,1,0)+ IF( SELF.Diff_attorneylastname,1,0)+ IF( SELF.Diff_firm,1,0)+ IF( SELF.Diff_attorneyaddress1,1,0)+ IF( SELF.Diff_attorneyaddress2,1,0)+ IF( SELF.Diff_attorneyaddresscity,1,0)+ IF( SELF.Diff_attorneyaddressstate,1,0)+ IF( SELF.Diff_attorneyaddresszipcode,1,0)+ IF( SELF.Diff_attorneyphone,1,0)+ IF( SELF.Diff_attorneyemail,1,0)+ IF( SELF.Diff_documenttypes,1,0)+ IF( SELF.Diff_corr_dateofdeath,1,0)+ IF( SELF.Diff_pdid,1,0)+ IF( SELF.Diff_pfrd_address_ind,1,0)+ IF( SELF.Diff_nid,1,0)+ IF( SELF.Diff_cln_title,1,0)+ IF( SELF.Diff_cln_fname,1,0)+ IF( SELF.Diff_cln_mname,1,0)+ IF( SELF.Diff_cln_lname,1,0)+ IF( SELF.Diff_cln_suffix,1,0)+ IF( SELF.Diff_cln_title2,1,0)+ IF( SELF.Diff_cln_fname2,1,0)+ IF( SELF.Diff_cln_mname2,1,0)+ IF( SELF.Diff_cln_lname2,1,0)+ IF( SELF.Diff_cln_suffix2,1,0)+ IF( SELF.Diff_persistent_record_id,1,0)+ IF( SELF.Diff_cname,1,0)+ IF( SELF.Diff_cleanaid,1,0)+ IF( SELF.Diff_addresstype,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_rawaid,1,0);
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
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_filedate := COUNT(GROUP,%Closest%.Diff_filedate);
    Count_Diff_dod := COUNT(GROUP,%Closest%.Diff_dod);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_masterid := COUNT(GROUP,%Closest%.Diff_masterid);
    Count_Diff_debtorfirstname := COUNT(GROUP,%Closest%.Diff_debtorfirstname);
    Count_Diff_debtorlastname := COUNT(GROUP,%Closest%.Diff_debtorlastname);
    Count_Diff_debtoraddress1 := COUNT(GROUP,%Closest%.Diff_debtoraddress1);
    Count_Diff_debtoraddress2 := COUNT(GROUP,%Closest%.Diff_debtoraddress2);
    Count_Diff_debtoraddresscity := COUNT(GROUP,%Closest%.Diff_debtoraddresscity);
    Count_Diff_debtoraddressstate := COUNT(GROUP,%Closest%.Diff_debtoraddressstate);
    Count_Diff_debtoraddresszipcode := COUNT(GROUP,%Closest%.Diff_debtoraddresszipcode);
    Count_Diff_dateofdeath := COUNT(GROUP,%Closest%.Diff_dateofdeath);
    Count_Diff_dateofbirth := COUNT(GROUP,%Closest%.Diff_dateofbirth);
    Count_Diff_isprobatelocated := COUNT(GROUP,%Closest%.Diff_isprobatelocated);
    Count_Diff_casenumber := COUNT(GROUP,%Closest%.Diff_casenumber);
    Count_Diff_filingdate := COUNT(GROUP,%Closest%.Diff_filingdate);
    Count_Diff_lastdatetofileclaim := COUNT(GROUP,%Closest%.Diff_lastdatetofileclaim);
    Count_Diff_issubjecttocreditorsclaim := COUNT(GROUP,%Closest%.Diff_issubjecttocreditorsclaim);
    Count_Diff_publicationstartdate := COUNT(GROUP,%Closest%.Diff_publicationstartdate);
    Count_Diff_isestateopen := COUNT(GROUP,%Closest%.Diff_isestateopen);
    Count_Diff_executorfirstname := COUNT(GROUP,%Closest%.Diff_executorfirstname);
    Count_Diff_executorlastname := COUNT(GROUP,%Closest%.Diff_executorlastname);
    Count_Diff_executoraddress1 := COUNT(GROUP,%Closest%.Diff_executoraddress1);
    Count_Diff_executoraddress2 := COUNT(GROUP,%Closest%.Diff_executoraddress2);
    Count_Diff_executoraddresscity := COUNT(GROUP,%Closest%.Diff_executoraddresscity);
    Count_Diff_executoraddressstate := COUNT(GROUP,%Closest%.Diff_executoraddressstate);
    Count_Diff_executoraddresszipcode := COUNT(GROUP,%Closest%.Diff_executoraddresszipcode);
    Count_Diff_executorphone := COUNT(GROUP,%Closest%.Diff_executorphone);
    Count_Diff_attorneyfirstname := COUNT(GROUP,%Closest%.Diff_attorneyfirstname);
    Count_Diff_attorneylastname := COUNT(GROUP,%Closest%.Diff_attorneylastname);
    Count_Diff_firm := COUNT(GROUP,%Closest%.Diff_firm);
    Count_Diff_attorneyaddress1 := COUNT(GROUP,%Closest%.Diff_attorneyaddress1);
    Count_Diff_attorneyaddress2 := COUNT(GROUP,%Closest%.Diff_attorneyaddress2);
    Count_Diff_attorneyaddresscity := COUNT(GROUP,%Closest%.Diff_attorneyaddresscity);
    Count_Diff_attorneyaddressstate := COUNT(GROUP,%Closest%.Diff_attorneyaddressstate);
    Count_Diff_attorneyaddresszipcode := COUNT(GROUP,%Closest%.Diff_attorneyaddresszipcode);
    Count_Diff_attorneyphone := COUNT(GROUP,%Closest%.Diff_attorneyphone);
    Count_Diff_attorneyemail := COUNT(GROUP,%Closest%.Diff_attorneyemail);
    Count_Diff_documenttypes := COUNT(GROUP,%Closest%.Diff_documenttypes);
    Count_Diff_corr_dateofdeath := COUNT(GROUP,%Closest%.Diff_corr_dateofdeath);
    Count_Diff_pdid := COUNT(GROUP,%Closest%.Diff_pdid);
    Count_Diff_pfrd_address_ind := COUNT(GROUP,%Closest%.Diff_pfrd_address_ind);
    Count_Diff_nid := COUNT(GROUP,%Closest%.Diff_nid);
    Count_Diff_cln_title := COUNT(GROUP,%Closest%.Diff_cln_title);
    Count_Diff_cln_fname := COUNT(GROUP,%Closest%.Diff_cln_fname);
    Count_Diff_cln_mname := COUNT(GROUP,%Closest%.Diff_cln_mname);
    Count_Diff_cln_lname := COUNT(GROUP,%Closest%.Diff_cln_lname);
    Count_Diff_cln_suffix := COUNT(GROUP,%Closest%.Diff_cln_suffix);
    Count_Diff_cln_title2 := COUNT(GROUP,%Closest%.Diff_cln_title2);
    Count_Diff_cln_fname2 := COUNT(GROUP,%Closest%.Diff_cln_fname2);
    Count_Diff_cln_mname2 := COUNT(GROUP,%Closest%.Diff_cln_mname2);
    Count_Diff_cln_lname2 := COUNT(GROUP,%Closest%.Diff_cln_lname2);
    Count_Diff_cln_suffix2 := COUNT(GROUP,%Closest%.Diff_cln_suffix2);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
    Count_Diff_cleanaid := COUNT(GROUP,%Closest%.Diff_cleanaid);
    Count_Diff_addresstype := COUNT(GROUP,%Closest%.Diff_addresstype);
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
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
