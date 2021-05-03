IMPORT SALT311;
IMPORT Scrubs_Patriot; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 111;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_country_name','invalid_address','invalid_zip','invalid_zip4','invalid_source','invalid_source_code','invalid_name','invalid_name_type','invalid_suffix');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_country_name' => 3,'invalid_address' => 4,'invalid_zip' => 5,'invalid_zip4' => 6,'invalid_source' => 7,'invalid_source_code' => 8,'invalid_name' => 9,'invalid_name_type' => 10,'invalid_suffix' => 11,0);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÃ¯-"&\'()./,# '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÃ¯-"&\'()./,# '))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÃ¯-"&\'()./,# '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789Ã¯:;-.@%&*()\'#/`$!_, <>{}[]^=+#?|"'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]^=+#?|"',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789Ã¯:;-.@%&*()\'#/`$!_, <>{}[]^=+#?|"'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789Ã¯:;-.@%&*()\'#/`$!_, <>{}[]^=+#?|"'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_country_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()/-&\'-.,:# '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := if ( SALT311.StringFind('"',s2[1],1)>0 and SALT311.StringFind('"',s2[LENGTH(TRIM(s2))],1)>0,s2[2..LENGTH(TRIM(s2))-1],s2 );// Remove quotes if required
  RETURN  s3;
END;
EXPORT InValidFT_invalid_country_name(SALT311.StrType s) := WHICH(SALT311.StringFind('"',s[1],1)<>0 and SALT311.StringFind('"',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()/-&\'-.,:# '))));
EXPORT InValidMessageFT_invalid_country_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.Inquotes('"'),SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()/-&\'-.,:# '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address(SALT311.StrType s) := WHICH(~Scrubs_Patriot.Fn_Allow_ws(s,'AlphaNumChar')>0);
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Patriot.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('0,5,9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zip4(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('0,4'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source(SALT311.StrType s) := WHICH(~Scrubs_Patriot.fn_valid_source(s)>0);
EXPORT InValidMessageFT_invalid_source(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Patriot.fn_valid_source'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789/-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_source_code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789/-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~Scrubs_Patriot.fn_valid_source_code(s)>0);
EXPORT InValidMessageFT_invalid_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789/-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT311.HygieneErrors.CustomFail('Scrubs_Patriot.fn_valid_source_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(~Scrubs_Patriot.fn_valid_name(s)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Patriot.fn_valid_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['AKA','DBA','FKA','COUNTRY','ENTITY','GOOD AKA','LOW AKA','PRIMARY','STRONG AKA','STRONG FKA','STRONG NKA','WEAK AKA','WEAK FKA',' ']);
EXPORT InValidMessageFT_invalid_name_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('AKA|DBA|FKA|COUNTRY|ENTITY|GOOD AKA|LOW AKA|PRIMARY|STRONG AKA|STRONG FKA|STRONG NKA|WEAK AKA|WEAK FKA| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_suffix(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_suffix(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['SR','JR','I','II','III','IV','V','VI','VII','VIII','IX','X','8TH',' ']);
EXPORT InValidMessageFT_invalid_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('SR|JR|I|II|III|IV|V|VI|VII|VIII|IX|X|8TH| '),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'pty_key','source','orig_pty_name','orig_vessel_name','country','name_type','addr_1','addr_2','addr_3','addr_4','addr_5','addr_6','addr_7','addr_8','addr_9','addr_10','remarks_1','remarks_2','remarks_3','remarks_4','remarks_5','remarks_6','remarks_7','remarks_8','remarks_9','remarks_10','remarks_11','remarks_12','remarks_13','remarks_14','remarks_15','remarks_16','remarks_17','remarks_18','remarks_19','remarks_20','remarks_21','remarks_22','remarks_23','remarks_24','remarks_25','remarks_26','remarks_27','remarks_28','remarks_29','remarks_30','cname','title','fname','mname','lname','suffix','a_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','global_sid','record_sid','did','aid_prim_range','aid_predir','aid_prim_name','aid_addr_suffix','aid_postdir','aid_unit_desig','aid_sec_range','aid_p_city_name','aid_v_city_name','aid_st','aid_zip','aid_zip4','aid_cart','aid_cr_sort_sz','aid_lot','aid_lot_order','aid_dpbc','aid_chk_digit','aid_record_type','aid_fips_st','aid_county','aid_geo_lat','aid_geo_long','aid_msa','aid_geo_blk','aid_geo_match','aid_err_stat','append_rawaid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'pty_key','source','orig_pty_name','orig_vessel_name','country','name_type','addr_1','addr_2','addr_3','addr_4','addr_5','addr_6','addr_7','addr_8','addr_9','addr_10','remarks_1','remarks_2','remarks_3','remarks_4','remarks_5','remarks_6','remarks_7','remarks_8','remarks_9','remarks_10','remarks_11','remarks_12','remarks_13','remarks_14','remarks_15','remarks_16','remarks_17','remarks_18','remarks_19','remarks_20','remarks_21','remarks_22','remarks_23','remarks_24','remarks_25','remarks_26','remarks_27','remarks_28','remarks_29','remarks_30','cname','title','fname','mname','lname','suffix','a_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','global_sid','record_sid','did','aid_prim_range','aid_predir','aid_prim_name','aid_addr_suffix','aid_postdir','aid_unit_desig','aid_sec_range','aid_p_city_name','aid_v_city_name','aid_st','aid_zip','aid_zip4','aid_cart','aid_cr_sort_sz','aid_lot','aid_lot_order','aid_dpbc','aid_chk_digit','aid_record_type','aid_fips_st','aid_county','aid_geo_lat','aid_geo_long','aid_msa','aid_geo_blk','aid_geo_match','aid_err_stat','append_rawaid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'pty_key' => 0,'source' => 1,'orig_pty_name' => 2,'orig_vessel_name' => 3,'country' => 4,'name_type' => 5,'addr_1' => 6,'addr_2' => 7,'addr_3' => 8,'addr_4' => 9,'addr_5' => 10,'addr_6' => 11,'addr_7' => 12,'addr_8' => 13,'addr_9' => 14,'addr_10' => 15,'remarks_1' => 16,'remarks_2' => 17,'remarks_3' => 18,'remarks_4' => 19,'remarks_5' => 20,'remarks_6' => 21,'remarks_7' => 22,'remarks_8' => 23,'remarks_9' => 24,'remarks_10' => 25,'remarks_11' => 26,'remarks_12' => 27,'remarks_13' => 28,'remarks_14' => 29,'remarks_15' => 30,'remarks_16' => 31,'remarks_17' => 32,'remarks_18' => 33,'remarks_19' => 34,'remarks_20' => 35,'remarks_21' => 36,'remarks_22' => 37,'remarks_23' => 38,'remarks_24' => 39,'remarks_25' => 40,'remarks_26' => 41,'remarks_27' => 42,'remarks_28' => 43,'remarks_29' => 44,'remarks_30' => 45,'cname' => 46,'title' => 47,'fname' => 48,'mname' => 49,'lname' => 50,'suffix' => 51,'a_score' => 52,'prim_range' => 53,'predir' => 54,'prim_name' => 55,'addr_suffix' => 56,'postdir' => 57,'unit_desig' => 58,'sec_range' => 59,'p_city_name' => 60,'v_city_name' => 61,'st' => 62,'zip' => 63,'zip4' => 64,'cart' => 65,'cr_sort_sz' => 66,'lot' => 67,'lot_order' => 68,'dpbc' => 69,'chk_digit' => 70,'record_type' => 71,'ace_fips_st' => 72,'county' => 73,'geo_lat' => 74,'geo_long' => 75,'msa' => 76,'geo_blk' => 77,'geo_match' => 78,'err_stat' => 79,'global_sid' => 80,'record_sid' => 81,'did' => 82,'aid_prim_range' => 83,'aid_predir' => 84,'aid_prim_name' => 85,'aid_addr_suffix' => 86,'aid_postdir' => 87,'aid_unit_desig' => 88,'aid_sec_range' => 89,'aid_p_city_name' => 90,'aid_v_city_name' => 91,'aid_st' => 92,'aid_zip' => 93,'aid_zip4' => 94,'aid_cart' => 95,'aid_cr_sort_sz' => 96,'aid_lot' => 97,'aid_lot_order' => 98,'aid_dpbc' => 99,'aid_chk_digit' => 100,'aid_record_type' => 101,'aid_fips_st' => 102,'aid_county' => 103,'aid_geo_lat' => 104,'aid_geo_long' => 105,'aid_msa' => 106,'aid_geo_blk' => 107,'aid_geo_match' => 108,'aid_err_stat' => 109,'append_rawaid' => 110,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','CUSTOM'],['CUSTOM'],['CUSTOM'],[],['QUOTES','ALLOW'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_pty_key(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_pty_key(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_pty_key(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_source(SALT311.StrType s0) := MakeFT_invalid_source(s0);
EXPORT InValid_source(SALT311.StrType s) := InValidFT_invalid_source(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_invalid_source(wh);
 
EXPORT Make_orig_pty_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_pty_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_pty_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_orig_vessel_name(SALT311.StrType s0) := s0;
EXPORT InValid_orig_vessel_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_vessel_name(UNSIGNED1 wh) := '';
 
EXPORT Make_country(SALT311.StrType s0) := MakeFT_invalid_country_name(s0);
EXPORT InValid_country(SALT311.StrType s) := InValidFT_invalid_country_name(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_invalid_country_name(wh);
 
EXPORT Make_name_type(SALT311.StrType s0) := MakeFT_invalid_name_type(s0);
EXPORT InValid_name_type(SALT311.StrType s) := InValidFT_invalid_name_type(s);
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type(wh);
 
EXPORT Make_addr_1(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_1(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_2(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_2(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_3(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_3(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_3(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_4(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_4(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_4(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_5(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_5(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_5(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_6(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_6(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_6(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_7(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_7(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_7(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_8(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_8(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_8(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_9(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_9(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_9(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_10(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_10(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_10(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_remarks_1(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_1(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_2(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_2(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_3(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_3(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_4(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_4(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_4(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_5(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_5(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_5(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_6(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_6(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_6(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_7(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_7(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_7(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_8(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_8(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_8(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_9(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_9(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_9(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_10(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_10(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_10(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_11(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_11(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_11(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_12(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_12(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_12(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_13(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_13(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_13(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_14(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_14(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_14(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_15(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_15(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_15(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_16(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_16(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_16(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_17(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_17(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_17(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_18(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_18(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_18(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_19(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_19(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_19(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_20(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_20(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_20(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_21(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_21(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_21(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_22(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_22(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_22(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_23(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_23(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_23(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_24(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_24(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_25(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_25(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_25(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_26(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_26(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_26(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_27(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_27(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_27(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_28(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_28(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_28(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_29(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_29(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_29(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_30(SALT311.StrType s0) := s0;
EXPORT InValid_remarks_30(SALT311.StrType s) := 0;
EXPORT InValidMessage_remarks_30(UNSIGNED1 wh) := '';
 
EXPORT Make_cname(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_cname(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_cname(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_title(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_title(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_mname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_suffix(SALT311.StrType s0) := MakeFT_invalid_suffix(s0);
EXPORT InValid_suffix(SALT311.StrType s) := InValidFT_invalid_suffix(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_suffix(wh);
 
EXPORT Make_a_score(SALT311.StrType s0) := s0;
EXPORT InValid_a_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_a_score(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
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
 
EXPORT Make_record_type(SALT311.StrType s0) := s0;
EXPORT InValid_record_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT311.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT311.StrType s0) := s0;
EXPORT InValid_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_global_sid(SALT311.StrType s0) := s0;
EXPORT InValid_global_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_record_sid(SALT311.StrType s0) := s0;
EXPORT InValid_record_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_aid_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_predir(SALT311.StrType s0) := s0;
EXPORT InValid_aid_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_aid_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_aid_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_aid_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_aid_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_aid_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_p_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_aid_p_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_v_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_aid_v_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_st(SALT311.StrType s0) := s0;
EXPORT InValid_aid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_st(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_zip(SALT311.StrType s0) := s0;
EXPORT InValid_aid_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_aid_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_cart(SALT311.StrType s0) := s0;
EXPORT InValid_aid_cart(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_cr_sort_sz(SALT311.StrType s0) := s0;
EXPORT InValid_aid_cr_sort_sz(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_lot(SALT311.StrType s0) := s0;
EXPORT InValid_aid_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_lot_order(SALT311.StrType s0) := s0;
EXPORT InValid_aid_lot_order(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_dpbc(SALT311.StrType s0) := s0;
EXPORT InValid_aid_dpbc(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_aid_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_record_type(SALT311.StrType s0) := s0;
EXPORT InValid_aid_record_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_fips_st(SALT311.StrType s0) := s0;
EXPORT InValid_aid_fips_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_county(SALT311.StrType s0) := s0;
EXPORT InValid_aid_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_county(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_geo_lat(SALT311.StrType s0) := s0;
EXPORT InValid_aid_geo_lat(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_geo_long(SALT311.StrType s0) := s0;
EXPORT InValid_aid_geo_long(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_msa(SALT311.StrType s0) := s0;
EXPORT InValid_aid_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_geo_blk(SALT311.StrType s0) := s0;
EXPORT InValid_aid_geo_blk(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_geo_match(SALT311.StrType s0) := s0;
EXPORT InValid_aid_geo_match(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_aid_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_aid_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_aid_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_append_rawaid(SALT311.StrType s0) := s0;
EXPORT InValid_append_rawaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_rawaid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Patriot;
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
    BOOLEAN Diff_pty_key;
    BOOLEAN Diff_source;
    BOOLEAN Diff_orig_pty_name;
    BOOLEAN Diff_orig_vessel_name;
    BOOLEAN Diff_country;
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_addr_1;
    BOOLEAN Diff_addr_2;
    BOOLEAN Diff_addr_3;
    BOOLEAN Diff_addr_4;
    BOOLEAN Diff_addr_5;
    BOOLEAN Diff_addr_6;
    BOOLEAN Diff_addr_7;
    BOOLEAN Diff_addr_8;
    BOOLEAN Diff_addr_9;
    BOOLEAN Diff_addr_10;
    BOOLEAN Diff_remarks_1;
    BOOLEAN Diff_remarks_2;
    BOOLEAN Diff_remarks_3;
    BOOLEAN Diff_remarks_4;
    BOOLEAN Diff_remarks_5;
    BOOLEAN Diff_remarks_6;
    BOOLEAN Diff_remarks_7;
    BOOLEAN Diff_remarks_8;
    BOOLEAN Diff_remarks_9;
    BOOLEAN Diff_remarks_10;
    BOOLEAN Diff_remarks_11;
    BOOLEAN Diff_remarks_12;
    BOOLEAN Diff_remarks_13;
    BOOLEAN Diff_remarks_14;
    BOOLEAN Diff_remarks_15;
    BOOLEAN Diff_remarks_16;
    BOOLEAN Diff_remarks_17;
    BOOLEAN Diff_remarks_18;
    BOOLEAN Diff_remarks_19;
    BOOLEAN Diff_remarks_20;
    BOOLEAN Diff_remarks_21;
    BOOLEAN Diff_remarks_22;
    BOOLEAN Diff_remarks_23;
    BOOLEAN Diff_remarks_24;
    BOOLEAN Diff_remarks_25;
    BOOLEAN Diff_remarks_26;
    BOOLEAN Diff_remarks_27;
    BOOLEAN Diff_remarks_28;
    BOOLEAN Diff_remarks_29;
    BOOLEAN Diff_remarks_30;
    BOOLEAN Diff_cname;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_a_score;
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
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_aid_prim_range;
    BOOLEAN Diff_aid_predir;
    BOOLEAN Diff_aid_prim_name;
    BOOLEAN Diff_aid_addr_suffix;
    BOOLEAN Diff_aid_postdir;
    BOOLEAN Diff_aid_unit_desig;
    BOOLEAN Diff_aid_sec_range;
    BOOLEAN Diff_aid_p_city_name;
    BOOLEAN Diff_aid_v_city_name;
    BOOLEAN Diff_aid_st;
    BOOLEAN Diff_aid_zip;
    BOOLEAN Diff_aid_zip4;
    BOOLEAN Diff_aid_cart;
    BOOLEAN Diff_aid_cr_sort_sz;
    BOOLEAN Diff_aid_lot;
    BOOLEAN Diff_aid_lot_order;
    BOOLEAN Diff_aid_dpbc;
    BOOLEAN Diff_aid_chk_digit;
    BOOLEAN Diff_aid_record_type;
    BOOLEAN Diff_aid_fips_st;
    BOOLEAN Diff_aid_county;
    BOOLEAN Diff_aid_geo_lat;
    BOOLEAN Diff_aid_geo_long;
    BOOLEAN Diff_aid_msa;
    BOOLEAN Diff_aid_geo_blk;
    BOOLEAN Diff_aid_geo_match;
    BOOLEAN Diff_aid_err_stat;
    BOOLEAN Diff_append_rawaid;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_pty_key := le.pty_key <> ri.pty_key;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_orig_pty_name := le.orig_pty_name <> ri.orig_pty_name;
    SELF.Diff_orig_vessel_name := le.orig_vessel_name <> ri.orig_vessel_name;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_addr_1 := le.addr_1 <> ri.addr_1;
    SELF.Diff_addr_2 := le.addr_2 <> ri.addr_2;
    SELF.Diff_addr_3 := le.addr_3 <> ri.addr_3;
    SELF.Diff_addr_4 := le.addr_4 <> ri.addr_4;
    SELF.Diff_addr_5 := le.addr_5 <> ri.addr_5;
    SELF.Diff_addr_6 := le.addr_6 <> ri.addr_6;
    SELF.Diff_addr_7 := le.addr_7 <> ri.addr_7;
    SELF.Diff_addr_8 := le.addr_8 <> ri.addr_8;
    SELF.Diff_addr_9 := le.addr_9 <> ri.addr_9;
    SELF.Diff_addr_10 := le.addr_10 <> ri.addr_10;
    SELF.Diff_remarks_1 := le.remarks_1 <> ri.remarks_1;
    SELF.Diff_remarks_2 := le.remarks_2 <> ri.remarks_2;
    SELF.Diff_remarks_3 := le.remarks_3 <> ri.remarks_3;
    SELF.Diff_remarks_4 := le.remarks_4 <> ri.remarks_4;
    SELF.Diff_remarks_5 := le.remarks_5 <> ri.remarks_5;
    SELF.Diff_remarks_6 := le.remarks_6 <> ri.remarks_6;
    SELF.Diff_remarks_7 := le.remarks_7 <> ri.remarks_7;
    SELF.Diff_remarks_8 := le.remarks_8 <> ri.remarks_8;
    SELF.Diff_remarks_9 := le.remarks_9 <> ri.remarks_9;
    SELF.Diff_remarks_10 := le.remarks_10 <> ri.remarks_10;
    SELF.Diff_remarks_11 := le.remarks_11 <> ri.remarks_11;
    SELF.Diff_remarks_12 := le.remarks_12 <> ri.remarks_12;
    SELF.Diff_remarks_13 := le.remarks_13 <> ri.remarks_13;
    SELF.Diff_remarks_14 := le.remarks_14 <> ri.remarks_14;
    SELF.Diff_remarks_15 := le.remarks_15 <> ri.remarks_15;
    SELF.Diff_remarks_16 := le.remarks_16 <> ri.remarks_16;
    SELF.Diff_remarks_17 := le.remarks_17 <> ri.remarks_17;
    SELF.Diff_remarks_18 := le.remarks_18 <> ri.remarks_18;
    SELF.Diff_remarks_19 := le.remarks_19 <> ri.remarks_19;
    SELF.Diff_remarks_20 := le.remarks_20 <> ri.remarks_20;
    SELF.Diff_remarks_21 := le.remarks_21 <> ri.remarks_21;
    SELF.Diff_remarks_22 := le.remarks_22 <> ri.remarks_22;
    SELF.Diff_remarks_23 := le.remarks_23 <> ri.remarks_23;
    SELF.Diff_remarks_24 := le.remarks_24 <> ri.remarks_24;
    SELF.Diff_remarks_25 := le.remarks_25 <> ri.remarks_25;
    SELF.Diff_remarks_26 := le.remarks_26 <> ri.remarks_26;
    SELF.Diff_remarks_27 := le.remarks_27 <> ri.remarks_27;
    SELF.Diff_remarks_28 := le.remarks_28 <> ri.remarks_28;
    SELF.Diff_remarks_29 := le.remarks_29 <> ri.remarks_29;
    SELF.Diff_remarks_30 := le.remarks_30 <> ri.remarks_30;
    SELF.Diff_cname := le.cname <> ri.cname;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_a_score := le.a_score <> ri.a_score;
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
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_aid_prim_range := le.aid_prim_range <> ri.aid_prim_range;
    SELF.Diff_aid_predir := le.aid_predir <> ri.aid_predir;
    SELF.Diff_aid_prim_name := le.aid_prim_name <> ri.aid_prim_name;
    SELF.Diff_aid_addr_suffix := le.aid_addr_suffix <> ri.aid_addr_suffix;
    SELF.Diff_aid_postdir := le.aid_postdir <> ri.aid_postdir;
    SELF.Diff_aid_unit_desig := le.aid_unit_desig <> ri.aid_unit_desig;
    SELF.Diff_aid_sec_range := le.aid_sec_range <> ri.aid_sec_range;
    SELF.Diff_aid_p_city_name := le.aid_p_city_name <> ri.aid_p_city_name;
    SELF.Diff_aid_v_city_name := le.aid_v_city_name <> ri.aid_v_city_name;
    SELF.Diff_aid_st := le.aid_st <> ri.aid_st;
    SELF.Diff_aid_zip := le.aid_zip <> ri.aid_zip;
    SELF.Diff_aid_zip4 := le.aid_zip4 <> ri.aid_zip4;
    SELF.Diff_aid_cart := le.aid_cart <> ri.aid_cart;
    SELF.Diff_aid_cr_sort_sz := le.aid_cr_sort_sz <> ri.aid_cr_sort_sz;
    SELF.Diff_aid_lot := le.aid_lot <> ri.aid_lot;
    SELF.Diff_aid_lot_order := le.aid_lot_order <> ri.aid_lot_order;
    SELF.Diff_aid_dpbc := le.aid_dpbc <> ri.aid_dpbc;
    SELF.Diff_aid_chk_digit := le.aid_chk_digit <> ri.aid_chk_digit;
    SELF.Diff_aid_record_type := le.aid_record_type <> ri.aid_record_type;
    SELF.Diff_aid_fips_st := le.aid_fips_st <> ri.aid_fips_st;
    SELF.Diff_aid_county := le.aid_county <> ri.aid_county;
    SELF.Diff_aid_geo_lat := le.aid_geo_lat <> ri.aid_geo_lat;
    SELF.Diff_aid_geo_long := le.aid_geo_long <> ri.aid_geo_long;
    SELF.Diff_aid_msa := le.aid_msa <> ri.aid_msa;
    SELF.Diff_aid_geo_blk := le.aid_geo_blk <> ri.aid_geo_blk;
    SELF.Diff_aid_geo_match := le.aid_geo_match <> ri.aid_geo_match;
    SELF.Diff_aid_err_stat := le.aid_err_stat <> ri.aid_err_stat;
    SELF.Diff_append_rawaid := le.append_rawaid <> ri.append_rawaid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.src_key;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_pty_key,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_orig_pty_name,1,0)+ IF( SELF.Diff_orig_vessel_name,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_addr_1,1,0)+ IF( SELF.Diff_addr_2,1,0)+ IF( SELF.Diff_addr_3,1,0)+ IF( SELF.Diff_addr_4,1,0)+ IF( SELF.Diff_addr_5,1,0)+ IF( SELF.Diff_addr_6,1,0)+ IF( SELF.Diff_addr_7,1,0)+ IF( SELF.Diff_addr_8,1,0)+ IF( SELF.Diff_addr_9,1,0)+ IF( SELF.Diff_addr_10,1,0)+ IF( SELF.Diff_remarks_1,1,0)+ IF( SELF.Diff_remarks_2,1,0)+ IF( SELF.Diff_remarks_3,1,0)+ IF( SELF.Diff_remarks_4,1,0)+ IF( SELF.Diff_remarks_5,1,0)+ IF( SELF.Diff_remarks_6,1,0)+ IF( SELF.Diff_remarks_7,1,0)+ IF( SELF.Diff_remarks_8,1,0)+ IF( SELF.Diff_remarks_9,1,0)+ IF( SELF.Diff_remarks_10,1,0)+ IF( SELF.Diff_remarks_11,1,0)+ IF( SELF.Diff_remarks_12,1,0)+ IF( SELF.Diff_remarks_13,1,0)+ IF( SELF.Diff_remarks_14,1,0)+ IF( SELF.Diff_remarks_15,1,0)+ IF( SELF.Diff_remarks_16,1,0)+ IF( SELF.Diff_remarks_17,1,0)+ IF( SELF.Diff_remarks_18,1,0)+ IF( SELF.Diff_remarks_19,1,0)+ IF( SELF.Diff_remarks_20,1,0)+ IF( SELF.Diff_remarks_21,1,0)+ IF( SELF.Diff_remarks_22,1,0)+ IF( SELF.Diff_remarks_23,1,0)+ IF( SELF.Diff_remarks_24,1,0)+ IF( SELF.Diff_remarks_25,1,0)+ IF( SELF.Diff_remarks_26,1,0)+ IF( SELF.Diff_remarks_27,1,0)+ IF( SELF.Diff_remarks_28,1,0)+ IF( SELF.Diff_remarks_29,1,0)+ IF( SELF.Diff_remarks_30,1,0)+ IF( SELF.Diff_cname,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_a_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_aid_prim_range,1,0)+ IF( SELF.Diff_aid_predir,1,0)+ IF( SELF.Diff_aid_prim_name,1,0)+ IF( SELF.Diff_aid_addr_suffix,1,0)+ IF( SELF.Diff_aid_postdir,1,0)+ IF( SELF.Diff_aid_unit_desig,1,0)+ IF( SELF.Diff_aid_sec_range,1,0)+ IF( SELF.Diff_aid_p_city_name,1,0)+ IF( SELF.Diff_aid_v_city_name,1,0)+ IF( SELF.Diff_aid_st,1,0)+ IF( SELF.Diff_aid_zip,1,0)+ IF( SELF.Diff_aid_zip4,1,0)+ IF( SELF.Diff_aid_cart,1,0)+ IF( SELF.Diff_aid_cr_sort_sz,1,0)+ IF( SELF.Diff_aid_lot,1,0)+ IF( SELF.Diff_aid_lot_order,1,0)+ IF( SELF.Diff_aid_dpbc,1,0)+ IF( SELF.Diff_aid_chk_digit,1,0)+ IF( SELF.Diff_aid_record_type,1,0)+ IF( SELF.Diff_aid_fips_st,1,0)+ IF( SELF.Diff_aid_county,1,0)+ IF( SELF.Diff_aid_geo_lat,1,0)+ IF( SELF.Diff_aid_geo_long,1,0)+ IF( SELF.Diff_aid_msa,1,0)+ IF( SELF.Diff_aid_geo_blk,1,0)+ IF( SELF.Diff_aid_geo_match,1,0)+ IF( SELF.Diff_aid_err_stat,1,0)+ IF( SELF.Diff_append_rawaid,1,0);
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
    Count_Diff_pty_key := COUNT(GROUP,%Closest%.Diff_pty_key);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_orig_pty_name := COUNT(GROUP,%Closest%.Diff_orig_pty_name);
    Count_Diff_orig_vessel_name := COUNT(GROUP,%Closest%.Diff_orig_vessel_name);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_addr_1 := COUNT(GROUP,%Closest%.Diff_addr_1);
    Count_Diff_addr_2 := COUNT(GROUP,%Closest%.Diff_addr_2);
    Count_Diff_addr_3 := COUNT(GROUP,%Closest%.Diff_addr_3);
    Count_Diff_addr_4 := COUNT(GROUP,%Closest%.Diff_addr_4);
    Count_Diff_addr_5 := COUNT(GROUP,%Closest%.Diff_addr_5);
    Count_Diff_addr_6 := COUNT(GROUP,%Closest%.Diff_addr_6);
    Count_Diff_addr_7 := COUNT(GROUP,%Closest%.Diff_addr_7);
    Count_Diff_addr_8 := COUNT(GROUP,%Closest%.Diff_addr_8);
    Count_Diff_addr_9 := COUNT(GROUP,%Closest%.Diff_addr_9);
    Count_Diff_addr_10 := COUNT(GROUP,%Closest%.Diff_addr_10);
    Count_Diff_remarks_1 := COUNT(GROUP,%Closest%.Diff_remarks_1);
    Count_Diff_remarks_2 := COUNT(GROUP,%Closest%.Diff_remarks_2);
    Count_Diff_remarks_3 := COUNT(GROUP,%Closest%.Diff_remarks_3);
    Count_Diff_remarks_4 := COUNT(GROUP,%Closest%.Diff_remarks_4);
    Count_Diff_remarks_5 := COUNT(GROUP,%Closest%.Diff_remarks_5);
    Count_Diff_remarks_6 := COUNT(GROUP,%Closest%.Diff_remarks_6);
    Count_Diff_remarks_7 := COUNT(GROUP,%Closest%.Diff_remarks_7);
    Count_Diff_remarks_8 := COUNT(GROUP,%Closest%.Diff_remarks_8);
    Count_Diff_remarks_9 := COUNT(GROUP,%Closest%.Diff_remarks_9);
    Count_Diff_remarks_10 := COUNT(GROUP,%Closest%.Diff_remarks_10);
    Count_Diff_remarks_11 := COUNT(GROUP,%Closest%.Diff_remarks_11);
    Count_Diff_remarks_12 := COUNT(GROUP,%Closest%.Diff_remarks_12);
    Count_Diff_remarks_13 := COUNT(GROUP,%Closest%.Diff_remarks_13);
    Count_Diff_remarks_14 := COUNT(GROUP,%Closest%.Diff_remarks_14);
    Count_Diff_remarks_15 := COUNT(GROUP,%Closest%.Diff_remarks_15);
    Count_Diff_remarks_16 := COUNT(GROUP,%Closest%.Diff_remarks_16);
    Count_Diff_remarks_17 := COUNT(GROUP,%Closest%.Diff_remarks_17);
    Count_Diff_remarks_18 := COUNT(GROUP,%Closest%.Diff_remarks_18);
    Count_Diff_remarks_19 := COUNT(GROUP,%Closest%.Diff_remarks_19);
    Count_Diff_remarks_20 := COUNT(GROUP,%Closest%.Diff_remarks_20);
    Count_Diff_remarks_21 := COUNT(GROUP,%Closest%.Diff_remarks_21);
    Count_Diff_remarks_22 := COUNT(GROUP,%Closest%.Diff_remarks_22);
    Count_Diff_remarks_23 := COUNT(GROUP,%Closest%.Diff_remarks_23);
    Count_Diff_remarks_24 := COUNT(GROUP,%Closest%.Diff_remarks_24);
    Count_Diff_remarks_25 := COUNT(GROUP,%Closest%.Diff_remarks_25);
    Count_Diff_remarks_26 := COUNT(GROUP,%Closest%.Diff_remarks_26);
    Count_Diff_remarks_27 := COUNT(GROUP,%Closest%.Diff_remarks_27);
    Count_Diff_remarks_28 := COUNT(GROUP,%Closest%.Diff_remarks_28);
    Count_Diff_remarks_29 := COUNT(GROUP,%Closest%.Diff_remarks_29);
    Count_Diff_remarks_30 := COUNT(GROUP,%Closest%.Diff_remarks_30);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_a_score := COUNT(GROUP,%Closest%.Diff_a_score);
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
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_aid_prim_range := COUNT(GROUP,%Closest%.Diff_aid_prim_range);
    Count_Diff_aid_predir := COUNT(GROUP,%Closest%.Diff_aid_predir);
    Count_Diff_aid_prim_name := COUNT(GROUP,%Closest%.Diff_aid_prim_name);
    Count_Diff_aid_addr_suffix := COUNT(GROUP,%Closest%.Diff_aid_addr_suffix);
    Count_Diff_aid_postdir := COUNT(GROUP,%Closest%.Diff_aid_postdir);
    Count_Diff_aid_unit_desig := COUNT(GROUP,%Closest%.Diff_aid_unit_desig);
    Count_Diff_aid_sec_range := COUNT(GROUP,%Closest%.Diff_aid_sec_range);
    Count_Diff_aid_p_city_name := COUNT(GROUP,%Closest%.Diff_aid_p_city_name);
    Count_Diff_aid_v_city_name := COUNT(GROUP,%Closest%.Diff_aid_v_city_name);
    Count_Diff_aid_st := COUNT(GROUP,%Closest%.Diff_aid_st);
    Count_Diff_aid_zip := COUNT(GROUP,%Closest%.Diff_aid_zip);
    Count_Diff_aid_zip4 := COUNT(GROUP,%Closest%.Diff_aid_zip4);
    Count_Diff_aid_cart := COUNT(GROUP,%Closest%.Diff_aid_cart);
    Count_Diff_aid_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_aid_cr_sort_sz);
    Count_Diff_aid_lot := COUNT(GROUP,%Closest%.Diff_aid_lot);
    Count_Diff_aid_lot_order := COUNT(GROUP,%Closest%.Diff_aid_lot_order);
    Count_Diff_aid_dpbc := COUNT(GROUP,%Closest%.Diff_aid_dpbc);
    Count_Diff_aid_chk_digit := COUNT(GROUP,%Closest%.Diff_aid_chk_digit);
    Count_Diff_aid_record_type := COUNT(GROUP,%Closest%.Diff_aid_record_type);
    Count_Diff_aid_fips_st := COUNT(GROUP,%Closest%.Diff_aid_fips_st);
    Count_Diff_aid_county := COUNT(GROUP,%Closest%.Diff_aid_county);
    Count_Diff_aid_geo_lat := COUNT(GROUP,%Closest%.Diff_aid_geo_lat);
    Count_Diff_aid_geo_long := COUNT(GROUP,%Closest%.Diff_aid_geo_long);
    Count_Diff_aid_msa := COUNT(GROUP,%Closest%.Diff_aid_msa);
    Count_Diff_aid_geo_blk := COUNT(GROUP,%Closest%.Diff_aid_geo_blk);
    Count_Diff_aid_geo_match := COUNT(GROUP,%Closest%.Diff_aid_geo_match);
    Count_Diff_aid_err_stat := COUNT(GROUP,%Closest%.Diff_aid_err_stat);
    Count_Diff_append_rawaid := COUNT(GROUP,%Closest%.Diff_append_rawaid);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
