IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 86;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Char','Invalid_Num','Invalid_CRSORT','Invalid_LotOrder','Invalid_RecType','Invalid_DemographicIndicator','Invalid_Gender','Invalid_LocationType','Invalid_TelephoneNumberType','Invalid_TimeZone','Invalid_YN','Invalid_HomeownerCode','Invalid_Source');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Char' => 1,'Invalid_Num' => 2,'Invalid_CRSORT' => 3,'Invalid_LotOrder' => 4,'Invalid_RecType' => 5,'Invalid_DemographicIndicator' => 6,'Invalid_Gender' => 7,'Invalid_LocationType' => 8,'Invalid_TelephoneNumberType' => 9,'Invalid_TimeZone' => 10,'Invalid_YN' => 11,'Invalid_HomeownerCode' => 12,'Invalid_Source' => 13,0);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789()-.\'/& '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789()-.\'/& '))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789()-.\'/& '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-0123456789. '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-0123456789. '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('-0123456789. '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CRSORT(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CRSORT(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','B','C','A','']);
EXPORT InValidMessageFT_Invalid_CRSORT(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|B|C|A|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LotOrder(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_LotOrder(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','D','']);
EXPORT InValidMessageFT_Invalid_LotOrder(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|D|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RecType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_RecType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['S','H','HD','P','SD','F','R','RD','UD','G','GD','']);
EXPORT InValidMessageFT_Invalid_RecType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('S|H|HD|P|SD|F|R|RD|UD|G|GD|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_DemographicIndicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_DemographicIndicator(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['B','Z','N','']);
EXPORT InValidMessageFT_Invalid_DemographicIndicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('B|Z|N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Gender(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Gender(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['M','F','U','']);
EXPORT InValidMessageFT_Invalid_Gender(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('M|F|U|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LocationType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_LocationType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['S','M','U','T','R','N','']);
EXPORT InValidMessageFT_Invalid_LocationType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('S|M|U|T|R|N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_TelephoneNumberType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_TelephoneNumberType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['V','G','U','F','B','T','O','C','M','D','P','']);
EXPORT InValidMessageFT_Invalid_TelephoneNumberType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('V|G|U|F|B|T|O|C|M|D|P|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_TimeZone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_TimeZone(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['E','C','P','M','H','A','']);
EXPORT InValidMessageFT_Invalid_TimeZone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('E|C|P|M|H|A|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_YN(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_YN(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_Invalid_YN(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_HomeownerCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_HomeownerCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['R','I','D','P','O','']);
EXPORT InValidMessageFT_Invalid_HomeownerCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('R|I|D|P|O|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Source(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Source(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['T','P','']);
EXPORT InValidMessageFT_Invalid_Source(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('T|P|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'title','fname','mname','lname','name_suffix','name_score','fname_orig','mname_orig','lname_orig','name_suffix_orig','title_orig','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','hhid','did','did_score','phone_fordid','gender','date_of_birth','address_type','demographic_level_indicator','length_of_residence','location_type','dqi2_occupancy_count','delivery_unit_size','household_arrival_date','area_code','phone_number','telephone_number_type','phone2_number','telephone2_number_type','time_zone','refresh_date','name_address_verification_source','drop_indicator','do_not_mail_flag','do_not_call_flag','business_file_hit_flag','spouse_title','spouse_fname','spouse_mname','spouse_lname','spouse_name_suffix','spouse_fname_orig','spouse_mname_orig','spouse_lname_orig','spouse_name_suffix_orig','spouse_title_orig','spouse_gender','spouse_date_of_birth','spouse_indicator','household_income','find_income_in_1000s','phhincomeunder25k','phhincome50kplus','phhincome200kplus','medianhhincome','own_rent','homeowner_source_code','telephone_acquisition_date','recency_date','source');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'title','fname','mname','lname','name_suffix','name_score','fname_orig','mname_orig','lname_orig','name_suffix_orig','title_orig','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','hhid','did','did_score','phone_fordid','gender','date_of_birth','address_type','demographic_level_indicator','length_of_residence','location_type','dqi2_occupancy_count','delivery_unit_size','household_arrival_date','area_code','phone_number','telephone_number_type','phone2_number','telephone2_number_type','time_zone','refresh_date','name_address_verification_source','drop_indicator','do_not_mail_flag','do_not_call_flag','business_file_hit_flag','spouse_title','spouse_fname','spouse_mname','spouse_lname','spouse_name_suffix','spouse_fname_orig','spouse_mname_orig','spouse_lname_orig','spouse_name_suffix_orig','spouse_title_orig','spouse_gender','spouse_date_of_birth','spouse_indicator','household_income','find_income_in_1000s','phhincomeunder25k','phhincome50kplus','phhincome200kplus','medianhhincome','own_rent','homeowner_source_code','telephone_acquisition_date','recency_date','source');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'title' => 0,'fname' => 1,'mname' => 2,'lname' => 3,'name_suffix' => 4,'name_score' => 5,'fname_orig' => 6,'mname_orig' => 7,'lname_orig' => 8,'name_suffix_orig' => 9,'title_orig' => 10,'prim_range' => 11,'predir' => 12,'prim_name' => 13,'addr_suffix' => 14,'postdir' => 15,'unit_desig' => 16,'sec_range' => 17,'p_city_name' => 18,'v_city_name' => 19,'st' => 20,'zip' => 21,'zip4' => 22,'cart' => 23,'cr_sort_sz' => 24,'lot' => 25,'lot_order' => 26,'dbpc' => 27,'chk_digit' => 28,'rec_type' => 29,'county' => 30,'geo_lat' => 31,'geo_long' => 32,'msa' => 33,'geo_blk' => 34,'geo_match' => 35,'err_stat' => 36,'hhid' => 37,'did' => 38,'did_score' => 39,'phone_fordid' => 40,'gender' => 41,'date_of_birth' => 42,'address_type' => 43,'demographic_level_indicator' => 44,'length_of_residence' => 45,'location_type' => 46,'dqi2_occupancy_count' => 47,'delivery_unit_size' => 48,'household_arrival_date' => 49,'area_code' => 50,'phone_number' => 51,'telephone_number_type' => 52,'phone2_number' => 53,'telephone2_number_type' => 54,'time_zone' => 55,'refresh_date' => 56,'name_address_verification_source' => 57,'drop_indicator' => 58,'do_not_mail_flag' => 59,'do_not_call_flag' => 60,'business_file_hit_flag' => 61,'spouse_title' => 62,'spouse_fname' => 63,'spouse_mname' => 64,'spouse_lname' => 65,'spouse_name_suffix' => 66,'spouse_fname_orig' => 67,'spouse_mname_orig' => 68,'spouse_lname_orig' => 69,'spouse_name_suffix_orig' => 70,'spouse_title_orig' => 71,'spouse_gender' => 72,'spouse_date_of_birth' => 73,'spouse_indicator' => 74,'household_income' => 75,'find_income_in_1000s' => 76,'phhincomeunder25k' => 77,'phhincome50kplus' => 78,'phhincome200kplus' => 79,'medianhhincome' => 80,'own_rent' => 81,'homeowner_source_code' => 82,'telephone_acquisition_date' => 83,'recency_date' => 84,'source' => 85,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ENUM'],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_title(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_title(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_name_score(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_fname_orig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_fname_orig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_fname_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mname_orig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mname_orig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mname_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lname_orig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_lname_orig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_lname_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_name_suffix_orig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_name_suffix_orig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_name_suffix_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_title_orig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_title_orig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_title_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT311.StrType s0) := s0;
EXPORT InValid_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_cart(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_cart(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_CRSORT(s0);
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_CRSORT(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_CRSORT(wh);
 
EXPORT Make_lot(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_lot(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_lot_order(SALT311.StrType s0) := MakeFT_Invalid_LotOrder(s0);
EXPORT InValid_lot_order(SALT311.StrType s) := InValidFT_Invalid_LotOrder(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_LotOrder(wh);
 
EXPORT Make_dbpc(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dbpc(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_chk_digit(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_rec_type(SALT311.StrType s0) := MakeFT_Invalid_RecType(s0);
EXPORT InValid_rec_type(SALT311.StrType s) := InValidFT_Invalid_RecType(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_RecType(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_long(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_msa(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_msa(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_blk(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_geo_match(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_match(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_err_stat(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_err_stat(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_hhid(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_hhid(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_hhid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_did(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_did_score(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did_score(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_phone_fordid(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_fordid(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_fordid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_Invalid_Gender(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_Invalid_Gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_Invalid_Gender(wh);
 
EXPORT Make_date_of_birth(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_date_of_birth(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_date_of_birth(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_address_type(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_address_type(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_address_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_demographic_level_indicator(SALT311.StrType s0) := MakeFT_Invalid_DemographicIndicator(s0);
EXPORT InValid_demographic_level_indicator(SALT311.StrType s) := InValidFT_Invalid_DemographicIndicator(s);
EXPORT InValidMessage_demographic_level_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_DemographicIndicator(wh);
 
EXPORT Make_length_of_residence(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_length_of_residence(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_length_of_residence(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_location_type(SALT311.StrType s0) := MakeFT_Invalid_LocationType(s0);
EXPORT InValid_location_type(SALT311.StrType s) := InValidFT_Invalid_LocationType(s);
EXPORT InValidMessage_location_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_LocationType(wh);
 
EXPORT Make_dqi2_occupancy_count(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dqi2_occupancy_count(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dqi2_occupancy_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_delivery_unit_size(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_delivery_unit_size(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_delivery_unit_size(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_household_arrival_date(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_household_arrival_date(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_household_arrival_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_area_code(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_area_code(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_area_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_phone_number(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_number(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_telephone_number_type(SALT311.StrType s0) := MakeFT_Invalid_TelephoneNumberType(s0);
EXPORT InValid_telephone_number_type(SALT311.StrType s) := InValidFT_Invalid_TelephoneNumberType(s);
EXPORT InValidMessage_telephone_number_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_TelephoneNumberType(wh);
 
EXPORT Make_phone2_number(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone2_number(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone2_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_telephone2_number_type(SALT311.StrType s0) := MakeFT_Invalid_TelephoneNumberType(s0);
EXPORT InValid_telephone2_number_type(SALT311.StrType s) := InValidFT_Invalid_TelephoneNumberType(s);
EXPORT InValidMessage_telephone2_number_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_TelephoneNumberType(wh);
 
EXPORT Make_time_zone(SALT311.StrType s0) := MakeFT_Invalid_TimeZone(s0);
EXPORT InValid_time_zone(SALT311.StrType s) := InValidFT_Invalid_TimeZone(s);
EXPORT InValidMessage_time_zone(UNSIGNED1 wh) := InValidMessageFT_Invalid_TimeZone(wh);
 
EXPORT Make_refresh_date(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_refresh_date(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_refresh_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_name_address_verification_source(SALT311.StrType s0) := MakeFT_Invalid_YN(s0);
EXPORT InValid_name_address_verification_source(SALT311.StrType s) := InValidFT_Invalid_YN(s);
EXPORT InValidMessage_name_address_verification_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_YN(wh);
 
EXPORT Make_drop_indicator(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_drop_indicator(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_drop_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_do_not_mail_flag(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_do_not_mail_flag(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_do_not_mail_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_do_not_call_flag(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_do_not_call_flag(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_do_not_call_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_business_file_hit_flag(SALT311.StrType s0) := MakeFT_Invalid_YN(s0);
EXPORT InValid_business_file_hit_flag(SALT311.StrType s) := InValidFT_Invalid_YN(s);
EXPORT InValidMessage_business_file_hit_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_YN(wh);
 
EXPORT Make_spouse_title(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_spouse_title(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_spouse_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_spouse_fname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_spouse_fname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_spouse_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_spouse_mname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_spouse_mname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_spouse_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_spouse_lname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_spouse_lname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_spouse_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_spouse_name_suffix(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_spouse_name_suffix(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_spouse_name_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_spouse_fname_orig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_spouse_fname_orig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_spouse_fname_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_spouse_mname_orig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_spouse_mname_orig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_spouse_mname_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_spouse_lname_orig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_spouse_lname_orig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_spouse_lname_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_spouse_name_suffix_orig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_spouse_name_suffix_orig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_spouse_name_suffix_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_spouse_title_orig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_spouse_title_orig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_spouse_title_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_spouse_gender(SALT311.StrType s0) := s0;
EXPORT InValid_spouse_gender(SALT311.StrType s) := 0;
EXPORT InValidMessage_spouse_gender(UNSIGNED1 wh) := '';
 
EXPORT Make_spouse_date_of_birth(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_spouse_date_of_birth(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_spouse_date_of_birth(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_spouse_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_spouse_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_spouse_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_household_income(SALT311.StrType s0) := s0;
EXPORT InValid_household_income(SALT311.StrType s) := 0;
EXPORT InValidMessage_household_income(UNSIGNED1 wh) := '';
 
EXPORT Make_find_income_in_1000s(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_find_income_in_1000s(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_find_income_in_1000s(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_phhincomeunder25k(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phhincomeunder25k(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phhincomeunder25k(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_phhincome50kplus(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phhincome50kplus(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phhincome50kplus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_phhincome200kplus(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phhincome200kplus(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phhincome200kplus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_medianhhincome(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_medianhhincome(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_medianhhincome(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_own_rent(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_own_rent(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_own_rent(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_homeowner_source_code(SALT311.StrType s0) := MakeFT_Invalid_HomeownerCode(s0);
EXPORT InValid_homeowner_source_code(SALT311.StrType s) := InValidFT_Invalid_HomeownerCode(s);
EXPORT InValidMessage_homeowner_source_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_HomeownerCode(wh);
 
EXPORT Make_telephone_acquisition_date(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_telephone_acquisition_date(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_telephone_acquisition_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_recency_date(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_recency_date(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_recency_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_source(SALT311.StrType s0) := MakeFT_Invalid_Source(s0);
EXPORT InValid_source(SALT311.StrType s) := InValidFT_Invalid_Source(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Source(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_PCNSR;
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
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_fname_orig;
    BOOLEAN Diff_mname_orig;
    BOOLEAN Diff_lname_orig;
    BOOLEAN Diff_name_suffix_orig;
    BOOLEAN Diff_title_orig;
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
    BOOLEAN Diff_hhid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_phone_fordid;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_date_of_birth;
    BOOLEAN Diff_address_type;
    BOOLEAN Diff_demographic_level_indicator;
    BOOLEAN Diff_length_of_residence;
    BOOLEAN Diff_location_type;
    BOOLEAN Diff_dqi2_occupancy_count;
    BOOLEAN Diff_delivery_unit_size;
    BOOLEAN Diff_household_arrival_date;
    BOOLEAN Diff_area_code;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_telephone_number_type;
    BOOLEAN Diff_phone2_number;
    BOOLEAN Diff_telephone2_number_type;
    BOOLEAN Diff_time_zone;
    BOOLEAN Diff_refresh_date;
    BOOLEAN Diff_name_address_verification_source;
    BOOLEAN Diff_drop_indicator;
    BOOLEAN Diff_do_not_mail_flag;
    BOOLEAN Diff_do_not_call_flag;
    BOOLEAN Diff_business_file_hit_flag;
    BOOLEAN Diff_spouse_title;
    BOOLEAN Diff_spouse_fname;
    BOOLEAN Diff_spouse_mname;
    BOOLEAN Diff_spouse_lname;
    BOOLEAN Diff_spouse_name_suffix;
    BOOLEAN Diff_spouse_fname_orig;
    BOOLEAN Diff_spouse_mname_orig;
    BOOLEAN Diff_spouse_lname_orig;
    BOOLEAN Diff_spouse_name_suffix_orig;
    BOOLEAN Diff_spouse_title_orig;
    BOOLEAN Diff_spouse_gender;
    BOOLEAN Diff_spouse_date_of_birth;
    BOOLEAN Diff_spouse_indicator;
    BOOLEAN Diff_household_income;
    BOOLEAN Diff_find_income_in_1000s;
    BOOLEAN Diff_phhincomeunder25k;
    BOOLEAN Diff_phhincome50kplus;
    BOOLEAN Diff_phhincome200kplus;
    BOOLEAN Diff_medianhhincome;
    BOOLEAN Diff_own_rent;
    BOOLEAN Diff_homeowner_source_code;
    BOOLEAN Diff_telephone_acquisition_date;
    BOOLEAN Diff_recency_date;
    BOOLEAN Diff_source;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_fname_orig := le.fname_orig <> ri.fname_orig;
    SELF.Diff_mname_orig := le.mname_orig <> ri.mname_orig;
    SELF.Diff_lname_orig := le.lname_orig <> ri.lname_orig;
    SELF.Diff_name_suffix_orig := le.name_suffix_orig <> ri.name_suffix_orig;
    SELF.Diff_title_orig := le.title_orig <> ri.title_orig;
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
    SELF.Diff_hhid := le.hhid <> ri.hhid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_phone_fordid := le.phone_fordid <> ri.phone_fordid;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_date_of_birth := le.date_of_birth <> ri.date_of_birth;
    SELF.Diff_address_type := le.address_type <> ri.address_type;
    SELF.Diff_demographic_level_indicator := le.demographic_level_indicator <> ri.demographic_level_indicator;
    SELF.Diff_length_of_residence := le.length_of_residence <> ri.length_of_residence;
    SELF.Diff_location_type := le.location_type <> ri.location_type;
    SELF.Diff_dqi2_occupancy_count := le.dqi2_occupancy_count <> ri.dqi2_occupancy_count;
    SELF.Diff_delivery_unit_size := le.delivery_unit_size <> ri.delivery_unit_size;
    SELF.Diff_household_arrival_date := le.household_arrival_date <> ri.household_arrival_date;
    SELF.Diff_area_code := le.area_code <> ri.area_code;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_telephone_number_type := le.telephone_number_type <> ri.telephone_number_type;
    SELF.Diff_phone2_number := le.phone2_number <> ri.phone2_number;
    SELF.Diff_telephone2_number_type := le.telephone2_number_type <> ri.telephone2_number_type;
    SELF.Diff_time_zone := le.time_zone <> ri.time_zone;
    SELF.Diff_refresh_date := le.refresh_date <> ri.refresh_date;
    SELF.Diff_name_address_verification_source := le.name_address_verification_source <> ri.name_address_verification_source;
    SELF.Diff_drop_indicator := le.drop_indicator <> ri.drop_indicator;
    SELF.Diff_do_not_mail_flag := le.do_not_mail_flag <> ri.do_not_mail_flag;
    SELF.Diff_do_not_call_flag := le.do_not_call_flag <> ri.do_not_call_flag;
    SELF.Diff_business_file_hit_flag := le.business_file_hit_flag <> ri.business_file_hit_flag;
    SELF.Diff_spouse_title := le.spouse_title <> ri.spouse_title;
    SELF.Diff_spouse_fname := le.spouse_fname <> ri.spouse_fname;
    SELF.Diff_spouse_mname := le.spouse_mname <> ri.spouse_mname;
    SELF.Diff_spouse_lname := le.spouse_lname <> ri.spouse_lname;
    SELF.Diff_spouse_name_suffix := le.spouse_name_suffix <> ri.spouse_name_suffix;
    SELF.Diff_spouse_fname_orig := le.spouse_fname_orig <> ri.spouse_fname_orig;
    SELF.Diff_spouse_mname_orig := le.spouse_mname_orig <> ri.spouse_mname_orig;
    SELF.Diff_spouse_lname_orig := le.spouse_lname_orig <> ri.spouse_lname_orig;
    SELF.Diff_spouse_name_suffix_orig := le.spouse_name_suffix_orig <> ri.spouse_name_suffix_orig;
    SELF.Diff_spouse_title_orig := le.spouse_title_orig <> ri.spouse_title_orig;
    SELF.Diff_spouse_gender := le.spouse_gender <> ri.spouse_gender;
    SELF.Diff_spouse_date_of_birth := le.spouse_date_of_birth <> ri.spouse_date_of_birth;
    SELF.Diff_spouse_indicator := le.spouse_indicator <> ri.spouse_indicator;
    SELF.Diff_household_income := le.household_income <> ri.household_income;
    SELF.Diff_find_income_in_1000s := le.find_income_in_1000s <> ri.find_income_in_1000s;
    SELF.Diff_phhincomeunder25k := le.phhincomeunder25k <> ri.phhincomeunder25k;
    SELF.Diff_phhincome50kplus := le.phhincome50kplus <> ri.phhincome50kplus;
    SELF.Diff_phhincome200kplus := le.phhincome200kplus <> ri.phhincome200kplus;
    SELF.Diff_medianhhincome := le.medianhhincome <> ri.medianhhincome;
    SELF.Diff_own_rent := le.own_rent <> ri.own_rent;
    SELF.Diff_homeowner_source_code := le.homeowner_source_code <> ri.homeowner_source_code;
    SELF.Diff_telephone_acquisition_date := le.telephone_acquisition_date <> ri.telephone_acquisition_date;
    SELF.Diff_recency_date := le.recency_date <> ri.recency_date;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_fname_orig,1,0)+ IF( SELF.Diff_mname_orig,1,0)+ IF( SELF.Diff_lname_orig,1,0)+ IF( SELF.Diff_name_suffix_orig,1,0)+ IF( SELF.Diff_title_orig,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_hhid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_phone_fordid,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_date_of_birth,1,0)+ IF( SELF.Diff_address_type,1,0)+ IF( SELF.Diff_demographic_level_indicator,1,0)+ IF( SELF.Diff_length_of_residence,1,0)+ IF( SELF.Diff_location_type,1,0)+ IF( SELF.Diff_dqi2_occupancy_count,1,0)+ IF( SELF.Diff_delivery_unit_size,1,0)+ IF( SELF.Diff_household_arrival_date,1,0)+ IF( SELF.Diff_area_code,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_telephone_number_type,1,0)+ IF( SELF.Diff_phone2_number,1,0)+ IF( SELF.Diff_telephone2_number_type,1,0)+ IF( SELF.Diff_time_zone,1,0)+ IF( SELF.Diff_refresh_date,1,0)+ IF( SELF.Diff_name_address_verification_source,1,0)+ IF( SELF.Diff_drop_indicator,1,0)+ IF( SELF.Diff_do_not_mail_flag,1,0)+ IF( SELF.Diff_do_not_call_flag,1,0)+ IF( SELF.Diff_business_file_hit_flag,1,0)+ IF( SELF.Diff_spouse_title,1,0)+ IF( SELF.Diff_spouse_fname,1,0)+ IF( SELF.Diff_spouse_mname,1,0)+ IF( SELF.Diff_spouse_lname,1,0)+ IF( SELF.Diff_spouse_name_suffix,1,0)+ IF( SELF.Diff_spouse_fname_orig,1,0)+ IF( SELF.Diff_spouse_mname_orig,1,0)+ IF( SELF.Diff_spouse_lname_orig,1,0)+ IF( SELF.Diff_spouse_name_suffix_orig,1,0)+ IF( SELF.Diff_spouse_title_orig,1,0)+ IF( SELF.Diff_spouse_gender,1,0)+ IF( SELF.Diff_spouse_date_of_birth,1,0)+ IF( SELF.Diff_spouse_indicator,1,0)+ IF( SELF.Diff_household_income,1,0)+ IF( SELF.Diff_find_income_in_1000s,1,0)+ IF( SELF.Diff_phhincomeunder25k,1,0)+ IF( SELF.Diff_phhincome50kplus,1,0)+ IF( SELF.Diff_phhincome200kplus,1,0)+ IF( SELF.Diff_medianhhincome,1,0)+ IF( SELF.Diff_own_rent,1,0)+ IF( SELF.Diff_homeowner_source_code,1,0)+ IF( SELF.Diff_telephone_acquisition_date,1,0)+ IF( SELF.Diff_recency_date,1,0)+ IF( SELF.Diff_source,1,0);
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
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_fname_orig := COUNT(GROUP,%Closest%.Diff_fname_orig);
    Count_Diff_mname_orig := COUNT(GROUP,%Closest%.Diff_mname_orig);
    Count_Diff_lname_orig := COUNT(GROUP,%Closest%.Diff_lname_orig);
    Count_Diff_name_suffix_orig := COUNT(GROUP,%Closest%.Diff_name_suffix_orig);
    Count_Diff_title_orig := COUNT(GROUP,%Closest%.Diff_title_orig);
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
    Count_Diff_hhid := COUNT(GROUP,%Closest%.Diff_hhid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_phone_fordid := COUNT(GROUP,%Closest%.Diff_phone_fordid);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_date_of_birth := COUNT(GROUP,%Closest%.Diff_date_of_birth);
    Count_Diff_address_type := COUNT(GROUP,%Closest%.Diff_address_type);
    Count_Diff_demographic_level_indicator := COUNT(GROUP,%Closest%.Diff_demographic_level_indicator);
    Count_Diff_length_of_residence := COUNT(GROUP,%Closest%.Diff_length_of_residence);
    Count_Diff_location_type := COUNT(GROUP,%Closest%.Diff_location_type);
    Count_Diff_dqi2_occupancy_count := COUNT(GROUP,%Closest%.Diff_dqi2_occupancy_count);
    Count_Diff_delivery_unit_size := COUNT(GROUP,%Closest%.Diff_delivery_unit_size);
    Count_Diff_household_arrival_date := COUNT(GROUP,%Closest%.Diff_household_arrival_date);
    Count_Diff_area_code := COUNT(GROUP,%Closest%.Diff_area_code);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_telephone_number_type := COUNT(GROUP,%Closest%.Diff_telephone_number_type);
    Count_Diff_phone2_number := COUNT(GROUP,%Closest%.Diff_phone2_number);
    Count_Diff_telephone2_number_type := COUNT(GROUP,%Closest%.Diff_telephone2_number_type);
    Count_Diff_time_zone := COUNT(GROUP,%Closest%.Diff_time_zone);
    Count_Diff_refresh_date := COUNT(GROUP,%Closest%.Diff_refresh_date);
    Count_Diff_name_address_verification_source := COUNT(GROUP,%Closest%.Diff_name_address_verification_source);
    Count_Diff_drop_indicator := COUNT(GROUP,%Closest%.Diff_drop_indicator);
    Count_Diff_do_not_mail_flag := COUNT(GROUP,%Closest%.Diff_do_not_mail_flag);
    Count_Diff_do_not_call_flag := COUNT(GROUP,%Closest%.Diff_do_not_call_flag);
    Count_Diff_business_file_hit_flag := COUNT(GROUP,%Closest%.Diff_business_file_hit_flag);
    Count_Diff_spouse_title := COUNT(GROUP,%Closest%.Diff_spouse_title);
    Count_Diff_spouse_fname := COUNT(GROUP,%Closest%.Diff_spouse_fname);
    Count_Diff_spouse_mname := COUNT(GROUP,%Closest%.Diff_spouse_mname);
    Count_Diff_spouse_lname := COUNT(GROUP,%Closest%.Diff_spouse_lname);
    Count_Diff_spouse_name_suffix := COUNT(GROUP,%Closest%.Diff_spouse_name_suffix);
    Count_Diff_spouse_fname_orig := COUNT(GROUP,%Closest%.Diff_spouse_fname_orig);
    Count_Diff_spouse_mname_orig := COUNT(GROUP,%Closest%.Diff_spouse_mname_orig);
    Count_Diff_spouse_lname_orig := COUNT(GROUP,%Closest%.Diff_spouse_lname_orig);
    Count_Diff_spouse_name_suffix_orig := COUNT(GROUP,%Closest%.Diff_spouse_name_suffix_orig);
    Count_Diff_spouse_title_orig := COUNT(GROUP,%Closest%.Diff_spouse_title_orig);
    Count_Diff_spouse_gender := COUNT(GROUP,%Closest%.Diff_spouse_gender);
    Count_Diff_spouse_date_of_birth := COUNT(GROUP,%Closest%.Diff_spouse_date_of_birth);
    Count_Diff_spouse_indicator := COUNT(GROUP,%Closest%.Diff_spouse_indicator);
    Count_Diff_household_income := COUNT(GROUP,%Closest%.Diff_household_income);
    Count_Diff_find_income_in_1000s := COUNT(GROUP,%Closest%.Diff_find_income_in_1000s);
    Count_Diff_phhincomeunder25k := COUNT(GROUP,%Closest%.Diff_phhincomeunder25k);
    Count_Diff_phhincome50kplus := COUNT(GROUP,%Closest%.Diff_phhincome50kplus);
    Count_Diff_phhincome200kplus := COUNT(GROUP,%Closest%.Diff_phhincome200kplus);
    Count_Diff_medianhhincome := COUNT(GROUP,%Closest%.Diff_medianhhincome);
    Count_Diff_own_rent := COUNT(GROUP,%Closest%.Diff_own_rent);
    Count_Diff_homeowner_source_code := COUNT(GROUP,%Closest%.Diff_homeowner_source_code);
    Count_Diff_telephone_acquisition_date := COUNT(GROUP,%Closest%.Diff_telephone_acquisition_date);
    Count_Diff_recency_date := COUNT(GROUP,%Closest%.Diff_recency_date);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
