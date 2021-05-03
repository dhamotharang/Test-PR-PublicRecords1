IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Companies_Fields := MODULE
 
EXPORT NumFields := 87;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Float','Invalid_Date','Invalid_AlphaCaps','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_State','Invalid_Zip');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Float' => 2,'Invalid_Date' => 3,'Invalid_AlphaCaps' => 4,'Invalid_AlphaNum' => 5,'Invalid_Alpha' => 6,'Invalid_AlphaChar' => 7,'Invalid_AlphaNumChar' => 8,'Invalid_State' => 9,'Invalid_Zip' => 10,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'NumChar')>0);
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Fn_Valid_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Fn_Valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaCaps(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaCaps(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_AlphaCaps(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'`.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'`.'))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'`.'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaChar')>0);
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaNumChar')>0);
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_Invalid_AlphaCaps(s1);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  RETURN  MakeFT_Invalid_Float(s0);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('0,5,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','bdid','bdid_score','raw_aid','ace_aid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawfields_maincompanyid','rawfields_companyname','rawfields_ticker','rawfields_fortunerank','rawfields_primaryindustry','rawfields_address1','rawfields_address2','rawfields_city','rawfields_state','rawfields_zip','rawfields_country','rawfields_region','rawfields_phone','rawfields_extension','rawfields_weburl','rawfields_sales','rawfields_employees','rawfields_competitors','rawfields_divisionname','rawfields_siccode','rawfields_auditor','rawfields_entrydate','rawfields_lastupdate','rawfields_entrystaffid','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','clean_dates_entrydate','clean_dates_lastupdate','clean_phones_phone','global_sid','record_sid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','bdid','bdid_score','raw_aid','ace_aid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawfields_maincompanyid','rawfields_companyname','rawfields_ticker','rawfields_fortunerank','rawfields_primaryindustry','rawfields_address1','rawfields_address2','rawfields_city','rawfields_state','rawfields_zip','rawfields_country','rawfields_region','rawfields_phone','rawfields_extension','rawfields_weburl','rawfields_sales','rawfields_employees','rawfields_competitors','rawfields_divisionname','rawfields_siccode','rawfields_auditor','rawfields_entrydate','rawfields_lastupdate','rawfields_entrystaffid','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','clean_dates_entrydate','clean_dates_lastupdate','clean_phones_phone','global_sid','record_sid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dotid' => 0,'dotscore' => 1,'dotweight' => 2,'empid' => 3,'empscore' => 4,'empweight' => 5,'powid' => 6,'powscore' => 7,'powweight' => 8,'proxid' => 9,'proxscore' => 10,'proxweight' => 11,'seleid' => 12,'selescore' => 13,'seleweight' => 14,'orgid' => 15,'orgscore' => 16,'orgweight' => 17,'ultid' => 18,'ultscore' => 19,'ultweight' => 20,'source_rec_id' => 21,'bdid' => 22,'bdid_score' => 23,'raw_aid' => 24,'ace_aid' => 25,'dt_first_seen' => 26,'dt_last_seen' => 27,'dt_vendor_first_reported' => 28,'dt_vendor_last_reported' => 29,'record_type' => 30,'rawfields_maincompanyid' => 31,'rawfields_companyname' => 32,'rawfields_ticker' => 33,'rawfields_fortunerank' => 34,'rawfields_primaryindustry' => 35,'rawfields_address1' => 36,'rawfields_address2' => 37,'rawfields_city' => 38,'rawfields_state' => 39,'rawfields_zip' => 40,'rawfields_country' => 41,'rawfields_region' => 42,'rawfields_phone' => 43,'rawfields_extension' => 44,'rawfields_weburl' => 45,'rawfields_sales' => 46,'rawfields_employees' => 47,'rawfields_competitors' => 48,'rawfields_divisionname' => 49,'rawfields_siccode' => 50,'rawfields_auditor' => 51,'rawfields_entrydate' => 52,'rawfields_lastupdate' => 53,'rawfields_entrystaffid' => 54,'clean_address_prim_range' => 55,'clean_address_predir' => 56,'clean_address_prim_name' => 57,'clean_address_addr_suffix' => 58,'clean_address_postdir' => 59,'clean_address_unit_desig' => 60,'clean_address_sec_range' => 61,'clean_address_p_city_name' => 62,'clean_address_v_city_name' => 63,'clean_address_st' => 64,'clean_address_zip' => 65,'clean_address_zip4' => 66,'clean_address_cart' => 67,'clean_address_cr_sort_sz' => 68,'clean_address_lot' => 69,'clean_address_lot_order' => 70,'clean_address_dbpc' => 71,'clean_address_chk_digit' => 72,'clean_address_rec_type' => 73,'clean_address_fips_state' => 74,'clean_address_fips_county' => 75,'clean_address_geo_lat' => 76,'clean_address_geo_long' => 77,'clean_address_msa' => 78,'clean_address_geo_blk' => 79,'clean_address_geo_match' => 80,'clean_address_err_stat' => 81,'clean_dates_entrydate' => 82,'clean_dates_lastupdate' => 83,'clean_phones_phone' => 84,'global_sid' => 85,'record_sid' => 86,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['LENGTHS'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dotid(SALT311.StrType s0) := s0;
EXPORT InValid_dotid(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_source_rec_id(SALT311.StrType s0) := s0;
EXPORT InValid_source_rec_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid(SALT311.StrType s0) := s0;
EXPORT InValid_bdid(SALT311.StrType s) := 0;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid_score(SALT311.StrType s0) := s0;
EXPORT InValid_bdid_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_aid(SALT311.StrType s0) := s0;
EXPORT InValid_raw_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_aid(SALT311.StrType s0) := s0;
EXPORT InValid_ace_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_rawfields_maincompanyid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_maincompanyid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_maincompanyid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_companyname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_companyname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_companyname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_ticker(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_rawfields_ticker(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_rawfields_ticker(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_rawfields_fortunerank(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_fortunerank(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_fortunerank(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_primaryindustry(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_primaryindustry(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_primaryindustry(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_address1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_rawfields_address1(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_rawfields_address1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_rawfields_address2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_rawfields_address2(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_rawfields_address2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_rawfields_city(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_city(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_rawfields_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_rawfields_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_rawfields_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_rawfields_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_rawfields_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_rawfields_country(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_country(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_region(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_rawfields_region(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_rawfields_region(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_rawfields_phone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_phone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_extension(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_extension(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_extension(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_weburl(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_weburl(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_weburl(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_sales(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_sales(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_sales(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_employees(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_employees(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_employees(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_competitors(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_competitors(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_competitors(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_divisionname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_divisionname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_divisionname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_siccode(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_siccode(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_siccode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_auditor(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_auditor(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_auditor(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_entrydate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_rawfields_entrydate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_rawfields_entrydate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_rawfields_lastupdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_rawfields_lastupdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_rawfields_lastupdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_rawfields_entrystaffid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_entrystaffid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_entrystaffid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_prim_range(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_prim_range(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_predir(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_address_predir(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_address_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_address_prim_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_clean_address_prim_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_clean_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_clean_address_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_address_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_address_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_address_postdir(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_address_postdir(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_address_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_address_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_address_unit_desig(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_address_sec_range(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_sec_range(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_address_p_city_name(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_address_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_address_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_address_v_city_name(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_address_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_address_st(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_address_st(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_address_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_address_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_clean_address_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_clean_address_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_clean_address_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_clean_address_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_clean_address_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_clean_address_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_address_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_address_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_address_lot(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_lot(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_lot_order(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_address_lot_order(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_address_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_address_dbpc(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_dbpc(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_dbpc(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_chk_digit(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_rec_type(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_address_rec_type(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_address_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_address_fips_state(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_fips_state(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_fips_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_fips_county(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_fips_county(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_fips_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_clean_address_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_clean_address_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_clean_address_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_clean_address_geo_long(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_clean_address_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_clean_address_msa(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_msa(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_geo_blk(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_geo_match(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_geo_match(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_err_stat(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_clean_address_err_stat(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_clean_address_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_clean_dates_entrydate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_clean_dates_entrydate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_clean_dates_entrydate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_clean_dates_lastupdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_clean_dates_lastupdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_clean_dates_lastupdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_clean_phones_phone(SALT311.StrType s0) := s0;
EXPORT InValid_clean_phones_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_phones_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_global_sid(SALT311.StrType s0) := s0;
EXPORT InValid_global_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_record_sid(SALT311.StrType s0) := s0;
EXPORT InValid_record_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Sheila_Greco;
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
    BOOLEAN Diff_source_rec_id;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_raw_aid;
    BOOLEAN Diff_ace_aid;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_rawfields_maincompanyid;
    BOOLEAN Diff_rawfields_companyname;
    BOOLEAN Diff_rawfields_ticker;
    BOOLEAN Diff_rawfields_fortunerank;
    BOOLEAN Diff_rawfields_primaryindustry;
    BOOLEAN Diff_rawfields_address1;
    BOOLEAN Diff_rawfields_address2;
    BOOLEAN Diff_rawfields_city;
    BOOLEAN Diff_rawfields_state;
    BOOLEAN Diff_rawfields_zip;
    BOOLEAN Diff_rawfields_country;
    BOOLEAN Diff_rawfields_region;
    BOOLEAN Diff_rawfields_phone;
    BOOLEAN Diff_rawfields_extension;
    BOOLEAN Diff_rawfields_weburl;
    BOOLEAN Diff_rawfields_sales;
    BOOLEAN Diff_rawfields_employees;
    BOOLEAN Diff_rawfields_competitors;
    BOOLEAN Diff_rawfields_divisionname;
    BOOLEAN Diff_rawfields_siccode;
    BOOLEAN Diff_rawfields_auditor;
    BOOLEAN Diff_rawfields_entrydate;
    BOOLEAN Diff_rawfields_lastupdate;
    BOOLEAN Diff_rawfields_entrystaffid;
    BOOLEAN Diff_clean_address_prim_range;
    BOOLEAN Diff_clean_address_predir;
    BOOLEAN Diff_clean_address_prim_name;
    BOOLEAN Diff_clean_address_addr_suffix;
    BOOLEAN Diff_clean_address_postdir;
    BOOLEAN Diff_clean_address_unit_desig;
    BOOLEAN Diff_clean_address_sec_range;
    BOOLEAN Diff_clean_address_p_city_name;
    BOOLEAN Diff_clean_address_v_city_name;
    BOOLEAN Diff_clean_address_st;
    BOOLEAN Diff_clean_address_zip;
    BOOLEAN Diff_clean_address_zip4;
    BOOLEAN Diff_clean_address_cart;
    BOOLEAN Diff_clean_address_cr_sort_sz;
    BOOLEAN Diff_clean_address_lot;
    BOOLEAN Diff_clean_address_lot_order;
    BOOLEAN Diff_clean_address_dbpc;
    BOOLEAN Diff_clean_address_chk_digit;
    BOOLEAN Diff_clean_address_rec_type;
    BOOLEAN Diff_clean_address_fips_state;
    BOOLEAN Diff_clean_address_fips_county;
    BOOLEAN Diff_clean_address_geo_lat;
    BOOLEAN Diff_clean_address_geo_long;
    BOOLEAN Diff_clean_address_msa;
    BOOLEAN Diff_clean_address_geo_blk;
    BOOLEAN Diff_clean_address_geo_match;
    BOOLEAN Diff_clean_address_err_stat;
    BOOLEAN Diff_clean_dates_entrydate;
    BOOLEAN Diff_clean_dates_lastupdate;
    BOOLEAN Diff_clean_phones_phone;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
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
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_raw_aid := le.raw_aid <> ri.raw_aid;
    SELF.Diff_ace_aid := le.ace_aid <> ri.ace_aid;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_rawfields_maincompanyid := le.rawfields_maincompanyid <> ri.rawfields_maincompanyid;
    SELF.Diff_rawfields_companyname := le.rawfields_companyname <> ri.rawfields_companyname;
    SELF.Diff_rawfields_ticker := le.rawfields_ticker <> ri.rawfields_ticker;
    SELF.Diff_rawfields_fortunerank := le.rawfields_fortunerank <> ri.rawfields_fortunerank;
    SELF.Diff_rawfields_primaryindustry := le.rawfields_primaryindustry <> ri.rawfields_primaryindustry;
    SELF.Diff_rawfields_address1 := le.rawfields_address1 <> ri.rawfields_address1;
    SELF.Diff_rawfields_address2 := le.rawfields_address2 <> ri.rawfields_address2;
    SELF.Diff_rawfields_city := le.rawfields_city <> ri.rawfields_city;
    SELF.Diff_rawfields_state := le.rawfields_state <> ri.rawfields_state;
    SELF.Diff_rawfields_zip := le.rawfields_zip <> ri.rawfields_zip;
    SELF.Diff_rawfields_country := le.rawfields_country <> ri.rawfields_country;
    SELF.Diff_rawfields_region := le.rawfields_region <> ri.rawfields_region;
    SELF.Diff_rawfields_phone := le.rawfields_phone <> ri.rawfields_phone;
    SELF.Diff_rawfields_extension := le.rawfields_extension <> ri.rawfields_extension;
    SELF.Diff_rawfields_weburl := le.rawfields_weburl <> ri.rawfields_weburl;
    SELF.Diff_rawfields_sales := le.rawfields_sales <> ri.rawfields_sales;
    SELF.Diff_rawfields_employees := le.rawfields_employees <> ri.rawfields_employees;
    SELF.Diff_rawfields_competitors := le.rawfields_competitors <> ri.rawfields_competitors;
    SELF.Diff_rawfields_divisionname := le.rawfields_divisionname <> ri.rawfields_divisionname;
    SELF.Diff_rawfields_siccode := le.rawfields_siccode <> ri.rawfields_siccode;
    SELF.Diff_rawfields_auditor := le.rawfields_auditor <> ri.rawfields_auditor;
    SELF.Diff_rawfields_entrydate := le.rawfields_entrydate <> ri.rawfields_entrydate;
    SELF.Diff_rawfields_lastupdate := le.rawfields_lastupdate <> ri.rawfields_lastupdate;
    SELF.Diff_rawfields_entrystaffid := le.rawfields_entrystaffid <> ri.rawfields_entrystaffid;
    SELF.Diff_clean_address_prim_range := le.clean_address_prim_range <> ri.clean_address_prim_range;
    SELF.Diff_clean_address_predir := le.clean_address_predir <> ri.clean_address_predir;
    SELF.Diff_clean_address_prim_name := le.clean_address_prim_name <> ri.clean_address_prim_name;
    SELF.Diff_clean_address_addr_suffix := le.clean_address_addr_suffix <> ri.clean_address_addr_suffix;
    SELF.Diff_clean_address_postdir := le.clean_address_postdir <> ri.clean_address_postdir;
    SELF.Diff_clean_address_unit_desig := le.clean_address_unit_desig <> ri.clean_address_unit_desig;
    SELF.Diff_clean_address_sec_range := le.clean_address_sec_range <> ri.clean_address_sec_range;
    SELF.Diff_clean_address_p_city_name := le.clean_address_p_city_name <> ri.clean_address_p_city_name;
    SELF.Diff_clean_address_v_city_name := le.clean_address_v_city_name <> ri.clean_address_v_city_name;
    SELF.Diff_clean_address_st := le.clean_address_st <> ri.clean_address_st;
    SELF.Diff_clean_address_zip := le.clean_address_zip <> ri.clean_address_zip;
    SELF.Diff_clean_address_zip4 := le.clean_address_zip4 <> ri.clean_address_zip4;
    SELF.Diff_clean_address_cart := le.clean_address_cart <> ri.clean_address_cart;
    SELF.Diff_clean_address_cr_sort_sz := le.clean_address_cr_sort_sz <> ri.clean_address_cr_sort_sz;
    SELF.Diff_clean_address_lot := le.clean_address_lot <> ri.clean_address_lot;
    SELF.Diff_clean_address_lot_order := le.clean_address_lot_order <> ri.clean_address_lot_order;
    SELF.Diff_clean_address_dbpc := le.clean_address_dbpc <> ri.clean_address_dbpc;
    SELF.Diff_clean_address_chk_digit := le.clean_address_chk_digit <> ri.clean_address_chk_digit;
    SELF.Diff_clean_address_rec_type := le.clean_address_rec_type <> ri.clean_address_rec_type;
    SELF.Diff_clean_address_fips_state := le.clean_address_fips_state <> ri.clean_address_fips_state;
    SELF.Diff_clean_address_fips_county := le.clean_address_fips_county <> ri.clean_address_fips_county;
    SELF.Diff_clean_address_geo_lat := le.clean_address_geo_lat <> ri.clean_address_geo_lat;
    SELF.Diff_clean_address_geo_long := le.clean_address_geo_long <> ri.clean_address_geo_long;
    SELF.Diff_clean_address_msa := le.clean_address_msa <> ri.clean_address_msa;
    SELF.Diff_clean_address_geo_blk := le.clean_address_geo_blk <> ri.clean_address_geo_blk;
    SELF.Diff_clean_address_geo_match := le.clean_address_geo_match <> ri.clean_address_geo_match;
    SELF.Diff_clean_address_err_stat := le.clean_address_err_stat <> ri.clean_address_err_stat;
    SELF.Diff_clean_dates_entrydate := le.clean_dates_entrydate <> ri.clean_dates_entrydate;
    SELF.Diff_clean_dates_lastupdate := le.clean_dates_lastupdate <> ri.clean_dates_lastupdate;
    SELF.Diff_clean_phones_phone := le.clean_phones_phone <> ri.clean_phones_phone;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_rawfields_maincompanyid,1,0)+ IF( SELF.Diff_rawfields_companyname,1,0)+ IF( SELF.Diff_rawfields_ticker,1,0)+ IF( SELF.Diff_rawfields_fortunerank,1,0)+ IF( SELF.Diff_rawfields_primaryindustry,1,0)+ IF( SELF.Diff_rawfields_address1,1,0)+ IF( SELF.Diff_rawfields_address2,1,0)+ IF( SELF.Diff_rawfields_city,1,0)+ IF( SELF.Diff_rawfields_state,1,0)+ IF( SELF.Diff_rawfields_zip,1,0)+ IF( SELF.Diff_rawfields_country,1,0)+ IF( SELF.Diff_rawfields_region,1,0)+ IF( SELF.Diff_rawfields_phone,1,0)+ IF( SELF.Diff_rawfields_extension,1,0)+ IF( SELF.Diff_rawfields_weburl,1,0)+ IF( SELF.Diff_rawfields_sales,1,0)+ IF( SELF.Diff_rawfields_employees,1,0)+ IF( SELF.Diff_rawfields_competitors,1,0)+ IF( SELF.Diff_rawfields_divisionname,1,0)+ IF( SELF.Diff_rawfields_siccode,1,0)+ IF( SELF.Diff_rawfields_auditor,1,0)+ IF( SELF.Diff_rawfields_entrydate,1,0)+ IF( SELF.Diff_rawfields_lastupdate,1,0)+ IF( SELF.Diff_rawfields_entrystaffid,1,0)+ IF( SELF.Diff_clean_address_prim_range,1,0)+ IF( SELF.Diff_clean_address_predir,1,0)+ IF( SELF.Diff_clean_address_prim_name,1,0)+ IF( SELF.Diff_clean_address_addr_suffix,1,0)+ IF( SELF.Diff_clean_address_postdir,1,0)+ IF( SELF.Diff_clean_address_unit_desig,1,0)+ IF( SELF.Diff_clean_address_sec_range,1,0)+ IF( SELF.Diff_clean_address_p_city_name,1,0)+ IF( SELF.Diff_clean_address_v_city_name,1,0)+ IF( SELF.Diff_clean_address_st,1,0)+ IF( SELF.Diff_clean_address_zip,1,0)+ IF( SELF.Diff_clean_address_zip4,1,0)+ IF( SELF.Diff_clean_address_cart,1,0)+ IF( SELF.Diff_clean_address_cr_sort_sz,1,0)+ IF( SELF.Diff_clean_address_lot,1,0)+ IF( SELF.Diff_clean_address_lot_order,1,0)+ IF( SELF.Diff_clean_address_dbpc,1,0)+ IF( SELF.Diff_clean_address_chk_digit,1,0)+ IF( SELF.Diff_clean_address_rec_type,1,0)+ IF( SELF.Diff_clean_address_fips_state,1,0)+ IF( SELF.Diff_clean_address_fips_county,1,0)+ IF( SELF.Diff_clean_address_geo_lat,1,0)+ IF( SELF.Diff_clean_address_geo_long,1,0)+ IF( SELF.Diff_clean_address_msa,1,0)+ IF( SELF.Diff_clean_address_geo_blk,1,0)+ IF( SELF.Diff_clean_address_geo_match,1,0)+ IF( SELF.Diff_clean_address_err_stat,1,0)+ IF( SELF.Diff_clean_dates_entrydate,1,0)+ IF( SELF.Diff_clean_dates_lastupdate,1,0)+ IF( SELF.Diff_clean_phones_phone,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0);
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
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_raw_aid := COUNT(GROUP,%Closest%.Diff_raw_aid);
    Count_Diff_ace_aid := COUNT(GROUP,%Closest%.Diff_ace_aid);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_rawfields_maincompanyid := COUNT(GROUP,%Closest%.Diff_rawfields_maincompanyid);
    Count_Diff_rawfields_companyname := COUNT(GROUP,%Closest%.Diff_rawfields_companyname);
    Count_Diff_rawfields_ticker := COUNT(GROUP,%Closest%.Diff_rawfields_ticker);
    Count_Diff_rawfields_fortunerank := COUNT(GROUP,%Closest%.Diff_rawfields_fortunerank);
    Count_Diff_rawfields_primaryindustry := COUNT(GROUP,%Closest%.Diff_rawfields_primaryindustry);
    Count_Diff_rawfields_address1 := COUNT(GROUP,%Closest%.Diff_rawfields_address1);
    Count_Diff_rawfields_address2 := COUNT(GROUP,%Closest%.Diff_rawfields_address2);
    Count_Diff_rawfields_city := COUNT(GROUP,%Closest%.Diff_rawfields_city);
    Count_Diff_rawfields_state := COUNT(GROUP,%Closest%.Diff_rawfields_state);
    Count_Diff_rawfields_zip := COUNT(GROUP,%Closest%.Diff_rawfields_zip);
    Count_Diff_rawfields_country := COUNT(GROUP,%Closest%.Diff_rawfields_country);
    Count_Diff_rawfields_region := COUNT(GROUP,%Closest%.Diff_rawfields_region);
    Count_Diff_rawfields_phone := COUNT(GROUP,%Closest%.Diff_rawfields_phone);
    Count_Diff_rawfields_extension := COUNT(GROUP,%Closest%.Diff_rawfields_extension);
    Count_Diff_rawfields_weburl := COUNT(GROUP,%Closest%.Diff_rawfields_weburl);
    Count_Diff_rawfields_sales := COUNT(GROUP,%Closest%.Diff_rawfields_sales);
    Count_Diff_rawfields_employees := COUNT(GROUP,%Closest%.Diff_rawfields_employees);
    Count_Diff_rawfields_competitors := COUNT(GROUP,%Closest%.Diff_rawfields_competitors);
    Count_Diff_rawfields_divisionname := COUNT(GROUP,%Closest%.Diff_rawfields_divisionname);
    Count_Diff_rawfields_siccode := COUNT(GROUP,%Closest%.Diff_rawfields_siccode);
    Count_Diff_rawfields_auditor := COUNT(GROUP,%Closest%.Diff_rawfields_auditor);
    Count_Diff_rawfields_entrydate := COUNT(GROUP,%Closest%.Diff_rawfields_entrydate);
    Count_Diff_rawfields_lastupdate := COUNT(GROUP,%Closest%.Diff_rawfields_lastupdate);
    Count_Diff_rawfields_entrystaffid := COUNT(GROUP,%Closest%.Diff_rawfields_entrystaffid);
    Count_Diff_clean_address_prim_range := COUNT(GROUP,%Closest%.Diff_clean_address_prim_range);
    Count_Diff_clean_address_predir := COUNT(GROUP,%Closest%.Diff_clean_address_predir);
    Count_Diff_clean_address_prim_name := COUNT(GROUP,%Closest%.Diff_clean_address_prim_name);
    Count_Diff_clean_address_addr_suffix := COUNT(GROUP,%Closest%.Diff_clean_address_addr_suffix);
    Count_Diff_clean_address_postdir := COUNT(GROUP,%Closest%.Diff_clean_address_postdir);
    Count_Diff_clean_address_unit_desig := COUNT(GROUP,%Closest%.Diff_clean_address_unit_desig);
    Count_Diff_clean_address_sec_range := COUNT(GROUP,%Closest%.Diff_clean_address_sec_range);
    Count_Diff_clean_address_p_city_name := COUNT(GROUP,%Closest%.Diff_clean_address_p_city_name);
    Count_Diff_clean_address_v_city_name := COUNT(GROUP,%Closest%.Diff_clean_address_v_city_name);
    Count_Diff_clean_address_st := COUNT(GROUP,%Closest%.Diff_clean_address_st);
    Count_Diff_clean_address_zip := COUNT(GROUP,%Closest%.Diff_clean_address_zip);
    Count_Diff_clean_address_zip4 := COUNT(GROUP,%Closest%.Diff_clean_address_zip4);
    Count_Diff_clean_address_cart := COUNT(GROUP,%Closest%.Diff_clean_address_cart);
    Count_Diff_clean_address_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_clean_address_cr_sort_sz);
    Count_Diff_clean_address_lot := COUNT(GROUP,%Closest%.Diff_clean_address_lot);
    Count_Diff_clean_address_lot_order := COUNT(GROUP,%Closest%.Diff_clean_address_lot_order);
    Count_Diff_clean_address_dbpc := COUNT(GROUP,%Closest%.Diff_clean_address_dbpc);
    Count_Diff_clean_address_chk_digit := COUNT(GROUP,%Closest%.Diff_clean_address_chk_digit);
    Count_Diff_clean_address_rec_type := COUNT(GROUP,%Closest%.Diff_clean_address_rec_type);
    Count_Diff_clean_address_fips_state := COUNT(GROUP,%Closest%.Diff_clean_address_fips_state);
    Count_Diff_clean_address_fips_county := COUNT(GROUP,%Closest%.Diff_clean_address_fips_county);
    Count_Diff_clean_address_geo_lat := COUNT(GROUP,%Closest%.Diff_clean_address_geo_lat);
    Count_Diff_clean_address_geo_long := COUNT(GROUP,%Closest%.Diff_clean_address_geo_long);
    Count_Diff_clean_address_msa := COUNT(GROUP,%Closest%.Diff_clean_address_msa);
    Count_Diff_clean_address_geo_blk := COUNT(GROUP,%Closest%.Diff_clean_address_geo_blk);
    Count_Diff_clean_address_geo_match := COUNT(GROUP,%Closest%.Diff_clean_address_geo_match);
    Count_Diff_clean_address_err_stat := COUNT(GROUP,%Closest%.Diff_clean_address_err_stat);
    Count_Diff_clean_dates_entrydate := COUNT(GROUP,%Closest%.Diff_clean_dates_entrydate);
    Count_Diff_clean_dates_lastupdate := COUNT(GROUP,%Closest%.Diff_clean_dates_lastupdate);
    Count_Diff_clean_phones_phone := COUNT(GROUP,%Closest%.Diff_clean_phones_phone);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
