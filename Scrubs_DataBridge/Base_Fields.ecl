IMPORT SALT311;
IMPORT Scrubs_DataBridge; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 124;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_generaldate','invalid_pastdate','invalid_record_type','invalid_numeric','invalid_st','invalid_zip5','invalid_phone','invalid_sic','invalid_url','invalid_email','invalid_mail_score','invalid_gender_code','invalid_email_present_flag','invalid_source_code','invalid_email_status');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_generaldate' => 2,'invalid_pastdate' => 3,'invalid_record_type' => 4,'invalid_numeric' => 5,'invalid_st' => 6,'invalid_zip5' => 7,'invalid_phone' => 8,'invalid_sic' => 9,'invalid_url' => 10,'invalid_email' => 11,'invalid_mail_score' => 12,'invalid_gender_code' => 13,'invalid_email_present_flag' => 14,'invalid_source_code' => 15,'invalid_email_status' => 16,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_generaldate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_generaldate(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_general_date(s)>0);
EXPORT InValidMessageFT_invalid_generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_general_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|H'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_sic(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_sic'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_url(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_url(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_url(s)>0);
EXPORT InValidMessageFT_invalid_url(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_url'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_score(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_score(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2','3','4','5','6','7','8']);
EXPORT InValidMessageFT_invalid_mail_score(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|3|4|5|6|7|8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1','2','3','4','UNDEFINED','']);
EXPORT InValidMessageFT_invalid_gender_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1|2|3|4|UNDEFINED|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email_present_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_email_present_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1','2','3']);
EXPORT InValidMessageFT_invalid_email_present_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1|2|3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1']);
EXPORT InValidMessageFT_invalid_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email_status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_email_status(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['VALID','INVALID','UNKNOWN','']);
EXPORT InValidMessageFT_invalid_email_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('VALID|INVALID|UNKNOWN|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','clean_company_name','clean_area_code','clean_telephone_num','mail_score_desc','name_gender_desc','title_desc_1','title_desc_2','title_desc_3','title_desc_4','sic8_desc_1','sic8_desc_2','sic8_desc_3','sic8_desc_4','sic6_desc_1','sic6_desc_2','sic6_desc_3','sic6_desc_4','sic6_desc_5','name','company','address','address2','city','state','scf','zip','zip4','mail_score','area_code','telephone_number','name_gender','name_prefix','name_first','name_middle_initial','name_last','suffix','title_code_1','title_code_2','title_code_3','title_code_4','web_address','sic8_1','sic8_2','sic8_3','sic8_4','sic6_1','sic6_2','sic6_3','sic6_4','sic6_5','transaction_date','database_site_id','database_individual_id','email','email_present_flag','site_source1','site_source2','site_source3','site_source4','site_source5','site_source6','site_source7','site_source8','site_source9','site_source10','individual_source1','individual_source2','individual_source3','individual_source4','individual_source5','individual_source6','individual_source7','individual_source8','individual_source9','individual_source10','email_status','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_address_line1','prep_address_line_last');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','clean_company_name','clean_area_code','clean_telephone_num','mail_score_desc','name_gender_desc','title_desc_1','title_desc_2','title_desc_3','title_desc_4','sic8_desc_1','sic8_desc_2','sic8_desc_3','sic8_desc_4','sic6_desc_1','sic6_desc_2','sic6_desc_3','sic6_desc_4','sic6_desc_5','name','company','address','address2','city','state','scf','zip','zip4','mail_score','area_code','telephone_number','name_gender','name_prefix','name_first','name_middle_initial','name_last','suffix','title_code_1','title_code_2','title_code_3','title_code_4','web_address','sic8_1','sic8_2','sic8_3','sic8_4','sic6_1','sic6_2','sic6_3','sic6_4','sic6_5','transaction_date','database_site_id','database_individual_id','email','email_present_flag','site_source1','site_source2','site_source3','site_source4','site_source5','site_source6','site_source7','site_source8','site_source9','site_source10','individual_source1','individual_source2','individual_source3','individual_source4','individual_source5','individual_source6','individual_source7','individual_source8','individual_source9','individual_source10','email_status','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_address_line1','prep_address_line_last');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'did' => 6,'dt_first_seen' => 7,'dt_last_seen' => 8,'dt_vendor_first_reported' => 9,'dt_vendor_last_reported' => 10,'process_date' => 11,'record_type' => 12,'clean_company_name' => 13,'clean_area_code' => 14,'clean_telephone_num' => 15,'mail_score_desc' => 16,'name_gender_desc' => 17,'title_desc_1' => 18,'title_desc_2' => 19,'title_desc_3' => 20,'title_desc_4' => 21,'sic8_desc_1' => 22,'sic8_desc_2' => 23,'sic8_desc_3' => 24,'sic8_desc_4' => 25,'sic6_desc_1' => 26,'sic6_desc_2' => 27,'sic6_desc_3' => 28,'sic6_desc_4' => 29,'sic6_desc_5' => 30,'name' => 31,'company' => 32,'address' => 33,'address2' => 34,'city' => 35,'state' => 36,'scf' => 37,'zip' => 38,'zip4' => 39,'mail_score' => 40,'area_code' => 41,'telephone_number' => 42,'name_gender' => 43,'name_prefix' => 44,'name_first' => 45,'name_middle_initial' => 46,'name_last' => 47,'suffix' => 48,'title_code_1' => 49,'title_code_2' => 50,'title_code_3' => 51,'title_code_4' => 52,'web_address' => 53,'sic8_1' => 54,'sic8_2' => 55,'sic8_3' => 56,'sic8_4' => 57,'sic6_1' => 58,'sic6_2' => 59,'sic6_3' => 60,'sic6_4' => 61,'sic6_5' => 62,'transaction_date' => 63,'database_site_id' => 64,'database_individual_id' => 65,'email' => 66,'email_present_flag' => 67,'site_source1' => 68,'site_source2' => 69,'site_source3' => 70,'site_source4' => 71,'site_source5' => 72,'site_source6' => 73,'site_source7' => 74,'site_source8' => 75,'site_source9' => 76,'site_source10' => 77,'individual_source1' => 78,'individual_source2' => 79,'individual_source3' => 80,'individual_source4' => 81,'individual_source5' => 82,'individual_source6' => 83,'individual_source7' => 84,'individual_source8' => 85,'individual_source9' => 86,'individual_source10' => 87,'email_status' => 88,'title' => 89,'fname' => 90,'mname' => 91,'lname' => 92,'name_suffix' => 93,'name_score' => 94,'prim_range' => 95,'predir' => 96,'prim_name' => 97,'addr_suffix' => 98,'postdir' => 99,'unit_desig' => 100,'sec_range' => 101,'p_city_name' => 102,'v_city_name' => 103,'st' => 104,'cart' => 105,'cr_sort_sz' => 106,'lot' => 107,'lot_order' => 108,'dbpc' => 109,'chk_digit' => 110,'rec_type' => 111,'fips_state' => 112,'fips_county' => 113,'geo_lat' => 114,'geo_long' => 115,'msa' => 116,'geo_blk' => 117,'geo_match' => 118,'err_stat' => 119,'raw_aid' => 120,'ace_aid' => 121,'prep_address_line1' => 122,'prep_address_line_last' => 123,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['LENGTHS'],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],['CUSTOM'],[],['ENUM'],[],[],['ENUM'],[],[],[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['ALLOW'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_powid(SALT311.StrType s0) := s0;
EXPORT InValid_powid(SALT311.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT311.StrType s0) := s0;
EXPORT InValid_proxid(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT311.StrType s0) := s0;
EXPORT InValid_seleid(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT311.StrType s0) := s0;
EXPORT InValid_orgid(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT311.StrType s0) := s0;
EXPORT InValid_ultid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid(SALT311.StrType s0) := s0;
EXPORT InValid_bdid(SALT311.StrType s) := 0;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_generaldate(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_generaldate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_generaldate(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_clean_company_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_company_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_area_code(SALT311.StrType s0) := s0;
EXPORT InValid_clean_area_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_area_code(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_telephone_num(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_clean_telephone_num(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_clean_telephone_num(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_mail_score_desc(SALT311.StrType s0) := s0;
EXPORT InValid_mail_score_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_score_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_name_gender_desc(SALT311.StrType s0) := s0;
EXPORT InValid_name_gender_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_gender_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_title_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_title_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_title_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_title_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_title_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_title_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_title_desc_3(SALT311.StrType s0) := s0;
EXPORT InValid_title_desc_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_title_desc_3(UNSIGNED1 wh) := '';
 
EXPORT Make_title_desc_4(SALT311.StrType s0) := s0;
EXPORT InValid_title_desc_4(SALT311.StrType s) := 0;
EXPORT InValidMessage_title_desc_4(UNSIGNED1 wh) := '';
 
EXPORT Make_sic8_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_sic8_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic8_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_sic8_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_sic8_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic8_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_sic8_desc_3(SALT311.StrType s0) := s0;
EXPORT InValid_sic8_desc_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic8_desc_3(UNSIGNED1 wh) := '';
 
EXPORT Make_sic8_desc_4(SALT311.StrType s0) := s0;
EXPORT InValid_sic8_desc_4(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic8_desc_4(UNSIGNED1 wh) := '';
 
EXPORT Make_sic6_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_sic6_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic6_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_sic6_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_sic6_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic6_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_sic6_desc_3(SALT311.StrType s0) := s0;
EXPORT InValid_sic6_desc_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic6_desc_3(UNSIGNED1 wh) := '';
 
EXPORT Make_sic6_desc_4(SALT311.StrType s0) := s0;
EXPORT InValid_sic6_desc_4(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic6_desc_4(UNSIGNED1 wh) := '';
 
EXPORT Make_sic6_desc_5(SALT311.StrType s0) := s0;
EXPORT InValid_sic6_desc_5(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic6_desc_5(UNSIGNED1 wh) := '';
 
EXPORT Make_name(SALT311.StrType s0) := s0;
EXPORT InValid_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_name(UNSIGNED1 wh) := '';
 
EXPORT Make_company(SALT311.StrType s0) := s0;
EXPORT InValid_company(SALT311.StrType s) := 0;
EXPORT InValidMessage_company(UNSIGNED1 wh) := '';
 
EXPORT Make_address(SALT311.StrType s0) := s0;
EXPORT InValid_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
 
EXPORT Make_address2(SALT311.StrType s0) := s0;
EXPORT InValid_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := s0;
EXPORT InValid_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_scf(SALT311.StrType s0) := s0;
EXPORT InValid_scf(SALT311.StrType s) := 0;
EXPORT InValidMessage_scf(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_score(SALT311.StrType s0) := MakeFT_invalid_mail_score(s0);
EXPORT InValid_mail_score(SALT311.StrType s) := InValidFT_invalid_mail_score(s);
EXPORT InValidMessage_mail_score(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_score(wh);
 
EXPORT Make_area_code(SALT311.StrType s0) := s0;
EXPORT InValid_area_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_area_code(UNSIGNED1 wh) := '';
 
EXPORT Make_telephone_number(SALT311.StrType s0) := s0;
EXPORT InValid_telephone_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_telephone_number(UNSIGNED1 wh) := '';
 
EXPORT Make_name_gender(SALT311.StrType s0) := MakeFT_invalid_gender_code(s0);
EXPORT InValid_name_gender(SALT311.StrType s) := InValidFT_invalid_gender_code(s);
EXPORT InValidMessage_name_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender_code(wh);
 
EXPORT Make_name_prefix(SALT311.StrType s0) := s0;
EXPORT InValid_name_prefix(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_first(SALT311.StrType s0) := s0;
EXPORT InValid_name_first(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_first(UNSIGNED1 wh) := '';
 
EXPORT Make_name_middle_initial(SALT311.StrType s0) := s0;
EXPORT InValid_name_middle_initial(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_middle_initial(UNSIGNED1 wh) := '';
 
EXPORT Make_name_last(SALT311.StrType s0) := s0;
EXPORT InValid_name_last(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_last(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_title_code_1(SALT311.StrType s0) := s0;
EXPORT InValid_title_code_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_title_code_1(UNSIGNED1 wh) := '';
 
EXPORT Make_title_code_2(SALT311.StrType s0) := s0;
EXPORT InValid_title_code_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_title_code_2(UNSIGNED1 wh) := '';
 
EXPORT Make_title_code_3(SALT311.StrType s0) := s0;
EXPORT InValid_title_code_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_title_code_3(UNSIGNED1 wh) := '';
 
EXPORT Make_title_code_4(SALT311.StrType s0) := s0;
EXPORT InValid_title_code_4(SALT311.StrType s) := 0;
EXPORT InValidMessage_title_code_4(UNSIGNED1 wh) := '';
 
EXPORT Make_web_address(SALT311.StrType s0) := MakeFT_invalid_url(s0);
EXPORT InValid_web_address(SALT311.StrType s) := InValidFT_invalid_url(s);
EXPORT InValidMessage_web_address(UNSIGNED1 wh) := InValidMessageFT_invalid_url(wh);
 
EXPORT Make_sic8_1(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic8_1(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic8_1(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic8_2(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic8_2(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic8_2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic8_3(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic8_3(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic8_3(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic8_4(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic8_4(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic8_4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic6_1(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic6_1(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic6_1(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic6_2(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic6_2(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic6_2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic6_3(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic6_3(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic6_3(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic6_4(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic6_4(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic6_4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic6_5(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic6_5(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic6_5(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_transaction_date(SALT311.StrType s0) := s0;
EXPORT InValid_transaction_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_transaction_date(UNSIGNED1 wh) := '';
 
EXPORT Make_database_site_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_database_site_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_database_site_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_database_individual_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_database_individual_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_database_individual_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_email(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_email_present_flag(SALT311.StrType s0) := MakeFT_invalid_email_present_flag(s0);
EXPORT InValid_email_present_flag(SALT311.StrType s) := InValidFT_invalid_email_present_flag(s);
EXPORT InValidMessage_email_present_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_email_present_flag(wh);
 
EXPORT Make_site_source1(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source1(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source1(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source2(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source2(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source2(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source3(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source3(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source3(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source4(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source4(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source4(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source5(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source5(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source5(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source6(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source6(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source6(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source7(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source7(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source7(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source8(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source8(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source8(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source9(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source9(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source9(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source10(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source10(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source10(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source1(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source1(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source1(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source2(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source2(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source2(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source3(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source3(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source3(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source4(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source4(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source4(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source5(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source5(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source5(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source6(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source6(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source6(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source7(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source7(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source7(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source8(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source8(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source8(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source9(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source9(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source9(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source10(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source10(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source10(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_email_status(SALT311.StrType s0) := MakeFT_invalid_email_status(s0);
EXPORT InValid_email_status(SALT311.StrType s) := InValidFT_invalid_email_status(s);
EXPORT InValidMessage_email_status(UNSIGNED1 wh) := InValidMessageFT_invalid_email_status(wh);
 
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
 
EXPORT Make_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_dbpc(SALT311.StrType s0) := s0;
EXPORT InValid_dbpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_state(SALT311.StrType s0) := s0;
EXPORT InValid_fips_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_raw_aid(SALT311.StrType s0) := s0;
EXPORT InValid_raw_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_aid(SALT311.StrType s0) := s0;
EXPORT InValid_ace_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_address_line1(SALT311.StrType s0) := s0;
EXPORT InValid_prep_address_line1(SALT311.StrType s) := 0;
EXPORT InValidMessage_prep_address_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_address_line_last(SALT311.StrType s0) := s0;
EXPORT InValid_prep_address_line_last(SALT311.StrType s) := 0;
EXPORT InValidMessage_prep_address_line_last(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_DataBridge;
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
    BOOLEAN Diff_powid;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_clean_company_name;
    BOOLEAN Diff_clean_area_code;
    BOOLEAN Diff_clean_telephone_num;
    BOOLEAN Diff_mail_score_desc;
    BOOLEAN Diff_name_gender_desc;
    BOOLEAN Diff_title_desc_1;
    BOOLEAN Diff_title_desc_2;
    BOOLEAN Diff_title_desc_3;
    BOOLEAN Diff_title_desc_4;
    BOOLEAN Diff_sic8_desc_1;
    BOOLEAN Diff_sic8_desc_2;
    BOOLEAN Diff_sic8_desc_3;
    BOOLEAN Diff_sic8_desc_4;
    BOOLEAN Diff_sic6_desc_1;
    BOOLEAN Diff_sic6_desc_2;
    BOOLEAN Diff_sic6_desc_3;
    BOOLEAN Diff_sic6_desc_4;
    BOOLEAN Diff_sic6_desc_5;
    BOOLEAN Diff_name;
    BOOLEAN Diff_company;
    BOOLEAN Diff_address;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_scf;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_mail_score;
    BOOLEAN Diff_area_code;
    BOOLEAN Diff_telephone_number;
    BOOLEAN Diff_name_gender;
    BOOLEAN Diff_name_prefix;
    BOOLEAN Diff_name_first;
    BOOLEAN Diff_name_middle_initial;
    BOOLEAN Diff_name_last;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_title_code_1;
    BOOLEAN Diff_title_code_2;
    BOOLEAN Diff_title_code_3;
    BOOLEAN Diff_title_code_4;
    BOOLEAN Diff_web_address;
    BOOLEAN Diff_sic8_1;
    BOOLEAN Diff_sic8_2;
    BOOLEAN Diff_sic8_3;
    BOOLEAN Diff_sic8_4;
    BOOLEAN Diff_sic6_1;
    BOOLEAN Diff_sic6_2;
    BOOLEAN Diff_sic6_3;
    BOOLEAN Diff_sic6_4;
    BOOLEAN Diff_sic6_5;
    BOOLEAN Diff_transaction_date;
    BOOLEAN Diff_database_site_id;
    BOOLEAN Diff_database_individual_id;
    BOOLEAN Diff_email;
    BOOLEAN Diff_email_present_flag;
    BOOLEAN Diff_site_source1;
    BOOLEAN Diff_site_source2;
    BOOLEAN Diff_site_source3;
    BOOLEAN Diff_site_source4;
    BOOLEAN Diff_site_source5;
    BOOLEAN Diff_site_source6;
    BOOLEAN Diff_site_source7;
    BOOLEAN Diff_site_source8;
    BOOLEAN Diff_site_source9;
    BOOLEAN Diff_site_source10;
    BOOLEAN Diff_individual_source1;
    BOOLEAN Diff_individual_source2;
    BOOLEAN Diff_individual_source3;
    BOOLEAN Diff_individual_source4;
    BOOLEAN Diff_individual_source5;
    BOOLEAN Diff_individual_source6;
    BOOLEAN Diff_individual_source7;
    BOOLEAN Diff_individual_source8;
    BOOLEAN Diff_individual_source9;
    BOOLEAN Diff_individual_source10;
    BOOLEAN Diff_email_status;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
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
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_raw_aid;
    BOOLEAN Diff_ace_aid;
    BOOLEAN Diff_prep_address_line1;
    BOOLEAN Diff_prep_address_line_last;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_clean_company_name := le.clean_company_name <> ri.clean_company_name;
    SELF.Diff_clean_area_code := le.clean_area_code <> ri.clean_area_code;
    SELF.Diff_clean_telephone_num := le.clean_telephone_num <> ri.clean_telephone_num;
    SELF.Diff_mail_score_desc := le.mail_score_desc <> ri.mail_score_desc;
    SELF.Diff_name_gender_desc := le.name_gender_desc <> ri.name_gender_desc;
    SELF.Diff_title_desc_1 := le.title_desc_1 <> ri.title_desc_1;
    SELF.Diff_title_desc_2 := le.title_desc_2 <> ri.title_desc_2;
    SELF.Diff_title_desc_3 := le.title_desc_3 <> ri.title_desc_3;
    SELF.Diff_title_desc_4 := le.title_desc_4 <> ri.title_desc_4;
    SELF.Diff_sic8_desc_1 := le.sic8_desc_1 <> ri.sic8_desc_1;
    SELF.Diff_sic8_desc_2 := le.sic8_desc_2 <> ri.sic8_desc_2;
    SELF.Diff_sic8_desc_3 := le.sic8_desc_3 <> ri.sic8_desc_3;
    SELF.Diff_sic8_desc_4 := le.sic8_desc_4 <> ri.sic8_desc_4;
    SELF.Diff_sic6_desc_1 := le.sic6_desc_1 <> ri.sic6_desc_1;
    SELF.Diff_sic6_desc_2 := le.sic6_desc_2 <> ri.sic6_desc_2;
    SELF.Diff_sic6_desc_3 := le.sic6_desc_3 <> ri.sic6_desc_3;
    SELF.Diff_sic6_desc_4 := le.sic6_desc_4 <> ri.sic6_desc_4;
    SELF.Diff_sic6_desc_5 := le.sic6_desc_5 <> ri.sic6_desc_5;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_company := le.company <> ri.company;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_scf := le.scf <> ri.scf;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_mail_score := le.mail_score <> ri.mail_score;
    SELF.Diff_area_code := le.area_code <> ri.area_code;
    SELF.Diff_telephone_number := le.telephone_number <> ri.telephone_number;
    SELF.Diff_name_gender := le.name_gender <> ri.name_gender;
    SELF.Diff_name_prefix := le.name_prefix <> ri.name_prefix;
    SELF.Diff_name_first := le.name_first <> ri.name_first;
    SELF.Diff_name_middle_initial := le.name_middle_initial <> ri.name_middle_initial;
    SELF.Diff_name_last := le.name_last <> ri.name_last;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_title_code_1 := le.title_code_1 <> ri.title_code_1;
    SELF.Diff_title_code_2 := le.title_code_2 <> ri.title_code_2;
    SELF.Diff_title_code_3 := le.title_code_3 <> ri.title_code_3;
    SELF.Diff_title_code_4 := le.title_code_4 <> ri.title_code_4;
    SELF.Diff_web_address := le.web_address <> ri.web_address;
    SELF.Diff_sic8_1 := le.sic8_1 <> ri.sic8_1;
    SELF.Diff_sic8_2 := le.sic8_2 <> ri.sic8_2;
    SELF.Diff_sic8_3 := le.sic8_3 <> ri.sic8_3;
    SELF.Diff_sic8_4 := le.sic8_4 <> ri.sic8_4;
    SELF.Diff_sic6_1 := le.sic6_1 <> ri.sic6_1;
    SELF.Diff_sic6_2 := le.sic6_2 <> ri.sic6_2;
    SELF.Diff_sic6_3 := le.sic6_3 <> ri.sic6_3;
    SELF.Diff_sic6_4 := le.sic6_4 <> ri.sic6_4;
    SELF.Diff_sic6_5 := le.sic6_5 <> ri.sic6_5;
    SELF.Diff_transaction_date := le.transaction_date <> ri.transaction_date;
    SELF.Diff_database_site_id := le.database_site_id <> ri.database_site_id;
    SELF.Diff_database_individual_id := le.database_individual_id <> ri.database_individual_id;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_email_present_flag := le.email_present_flag <> ri.email_present_flag;
    SELF.Diff_site_source1 := le.site_source1 <> ri.site_source1;
    SELF.Diff_site_source2 := le.site_source2 <> ri.site_source2;
    SELF.Diff_site_source3 := le.site_source3 <> ri.site_source3;
    SELF.Diff_site_source4 := le.site_source4 <> ri.site_source4;
    SELF.Diff_site_source5 := le.site_source5 <> ri.site_source5;
    SELF.Diff_site_source6 := le.site_source6 <> ri.site_source6;
    SELF.Diff_site_source7 := le.site_source7 <> ri.site_source7;
    SELF.Diff_site_source8 := le.site_source8 <> ri.site_source8;
    SELF.Diff_site_source9 := le.site_source9 <> ri.site_source9;
    SELF.Diff_site_source10 := le.site_source10 <> ri.site_source10;
    SELF.Diff_individual_source1 := le.individual_source1 <> ri.individual_source1;
    SELF.Diff_individual_source2 := le.individual_source2 <> ri.individual_source2;
    SELF.Diff_individual_source3 := le.individual_source3 <> ri.individual_source3;
    SELF.Diff_individual_source4 := le.individual_source4 <> ri.individual_source4;
    SELF.Diff_individual_source5 := le.individual_source5 <> ri.individual_source5;
    SELF.Diff_individual_source6 := le.individual_source6 <> ri.individual_source6;
    SELF.Diff_individual_source7 := le.individual_source7 <> ri.individual_source7;
    SELF.Diff_individual_source8 := le.individual_source8 <> ri.individual_source8;
    SELF.Diff_individual_source9 := le.individual_source9 <> ri.individual_source9;
    SELF.Diff_individual_source10 := le.individual_source10 <> ri.individual_source10;
    SELF.Diff_email_status := le.email_status <> ri.email_status;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
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
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_raw_aid := le.raw_aid <> ri.raw_aid;
    SELF.Diff_ace_aid := le.ace_aid <> ri.ace_aid;
    SELF.Diff_prep_address_line1 := le.prep_address_line1 <> ri.prep_address_line1;
    SELF.Diff_prep_address_line_last := le.prep_address_line_last <> ri.prep_address_line_last;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_clean_company_name,1,0)+ IF( SELF.Diff_clean_area_code,1,0)+ IF( SELF.Diff_clean_telephone_num,1,0)+ IF( SELF.Diff_mail_score_desc,1,0)+ IF( SELF.Diff_name_gender_desc,1,0)+ IF( SELF.Diff_title_desc_1,1,0)+ IF( SELF.Diff_title_desc_2,1,0)+ IF( SELF.Diff_title_desc_3,1,0)+ IF( SELF.Diff_title_desc_4,1,0)+ IF( SELF.Diff_sic8_desc_1,1,0)+ IF( SELF.Diff_sic8_desc_2,1,0)+ IF( SELF.Diff_sic8_desc_3,1,0)+ IF( SELF.Diff_sic8_desc_4,1,0)+ IF( SELF.Diff_sic6_desc_1,1,0)+ IF( SELF.Diff_sic6_desc_2,1,0)+ IF( SELF.Diff_sic6_desc_3,1,0)+ IF( SELF.Diff_sic6_desc_4,1,0)+ IF( SELF.Diff_sic6_desc_5,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_company,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_scf,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_mail_score,1,0)+ IF( SELF.Diff_area_code,1,0)+ IF( SELF.Diff_telephone_number,1,0)+ IF( SELF.Diff_name_gender,1,0)+ IF( SELF.Diff_name_prefix,1,0)+ IF( SELF.Diff_name_first,1,0)+ IF( SELF.Diff_name_middle_initial,1,0)+ IF( SELF.Diff_name_last,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_title_code_1,1,0)+ IF( SELF.Diff_title_code_2,1,0)+ IF( SELF.Diff_title_code_3,1,0)+ IF( SELF.Diff_title_code_4,1,0)+ IF( SELF.Diff_web_address,1,0)+ IF( SELF.Diff_sic8_1,1,0)+ IF( SELF.Diff_sic8_2,1,0)+ IF( SELF.Diff_sic8_3,1,0)+ IF( SELF.Diff_sic8_4,1,0)+ IF( SELF.Diff_sic6_1,1,0)+ IF( SELF.Diff_sic6_2,1,0)+ IF( SELF.Diff_sic6_3,1,0)+ IF( SELF.Diff_sic6_4,1,0)+ IF( SELF.Diff_sic6_5,1,0)+ IF( SELF.Diff_transaction_date,1,0)+ IF( SELF.Diff_database_site_id,1,0)+ IF( SELF.Diff_database_individual_id,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_email_present_flag,1,0)+ IF( SELF.Diff_site_source1,1,0)+ IF( SELF.Diff_site_source2,1,0)+ IF( SELF.Diff_site_source3,1,0)+ IF( SELF.Diff_site_source4,1,0)+ IF( SELF.Diff_site_source5,1,0)+ IF( SELF.Diff_site_source6,1,0)+ IF( SELF.Diff_site_source7,1,0)+ IF( SELF.Diff_site_source8,1,0)+ IF( SELF.Diff_site_source9,1,0)+ IF( SELF.Diff_site_source10,1,0)+ IF( SELF.Diff_individual_source1,1,0)+ IF( SELF.Diff_individual_source2,1,0)+ IF( SELF.Diff_individual_source3,1,0)+ IF( SELF.Diff_individual_source4,1,0)+ IF( SELF.Diff_individual_source5,1,0)+ IF( SELF.Diff_individual_source6,1,0)+ IF( SELF.Diff_individual_source7,1,0)+ IF( SELF.Diff_individual_source8,1,0)+ IF( SELF.Diff_individual_source9,1,0)+ IF( SELF.Diff_individual_source10,1,0)+ IF( SELF.Diff_email_status,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_prep_address_line1,1,0)+ IF( SELF.Diff_prep_address_line_last,1,0);
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
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_clean_company_name := COUNT(GROUP,%Closest%.Diff_clean_company_name);
    Count_Diff_clean_area_code := COUNT(GROUP,%Closest%.Diff_clean_area_code);
    Count_Diff_clean_telephone_num := COUNT(GROUP,%Closest%.Diff_clean_telephone_num);
    Count_Diff_mail_score_desc := COUNT(GROUP,%Closest%.Diff_mail_score_desc);
    Count_Diff_name_gender_desc := COUNT(GROUP,%Closest%.Diff_name_gender_desc);
    Count_Diff_title_desc_1 := COUNT(GROUP,%Closest%.Diff_title_desc_1);
    Count_Diff_title_desc_2 := COUNT(GROUP,%Closest%.Diff_title_desc_2);
    Count_Diff_title_desc_3 := COUNT(GROUP,%Closest%.Diff_title_desc_3);
    Count_Diff_title_desc_4 := COUNT(GROUP,%Closest%.Diff_title_desc_4);
    Count_Diff_sic8_desc_1 := COUNT(GROUP,%Closest%.Diff_sic8_desc_1);
    Count_Diff_sic8_desc_2 := COUNT(GROUP,%Closest%.Diff_sic8_desc_2);
    Count_Diff_sic8_desc_3 := COUNT(GROUP,%Closest%.Diff_sic8_desc_3);
    Count_Diff_sic8_desc_4 := COUNT(GROUP,%Closest%.Diff_sic8_desc_4);
    Count_Diff_sic6_desc_1 := COUNT(GROUP,%Closest%.Diff_sic6_desc_1);
    Count_Diff_sic6_desc_2 := COUNT(GROUP,%Closest%.Diff_sic6_desc_2);
    Count_Diff_sic6_desc_3 := COUNT(GROUP,%Closest%.Diff_sic6_desc_3);
    Count_Diff_sic6_desc_4 := COUNT(GROUP,%Closest%.Diff_sic6_desc_4);
    Count_Diff_sic6_desc_5 := COUNT(GROUP,%Closest%.Diff_sic6_desc_5);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_company := COUNT(GROUP,%Closest%.Diff_company);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_scf := COUNT(GROUP,%Closest%.Diff_scf);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_mail_score := COUNT(GROUP,%Closest%.Diff_mail_score);
    Count_Diff_area_code := COUNT(GROUP,%Closest%.Diff_area_code);
    Count_Diff_telephone_number := COUNT(GROUP,%Closest%.Diff_telephone_number);
    Count_Diff_name_gender := COUNT(GROUP,%Closest%.Diff_name_gender);
    Count_Diff_name_prefix := COUNT(GROUP,%Closest%.Diff_name_prefix);
    Count_Diff_name_first := COUNT(GROUP,%Closest%.Diff_name_first);
    Count_Diff_name_middle_initial := COUNT(GROUP,%Closest%.Diff_name_middle_initial);
    Count_Diff_name_last := COUNT(GROUP,%Closest%.Diff_name_last);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_title_code_1 := COUNT(GROUP,%Closest%.Diff_title_code_1);
    Count_Diff_title_code_2 := COUNT(GROUP,%Closest%.Diff_title_code_2);
    Count_Diff_title_code_3 := COUNT(GROUP,%Closest%.Diff_title_code_3);
    Count_Diff_title_code_4 := COUNT(GROUP,%Closest%.Diff_title_code_4);
    Count_Diff_web_address := COUNT(GROUP,%Closest%.Diff_web_address);
    Count_Diff_sic8_1 := COUNT(GROUP,%Closest%.Diff_sic8_1);
    Count_Diff_sic8_2 := COUNT(GROUP,%Closest%.Diff_sic8_2);
    Count_Diff_sic8_3 := COUNT(GROUP,%Closest%.Diff_sic8_3);
    Count_Diff_sic8_4 := COUNT(GROUP,%Closest%.Diff_sic8_4);
    Count_Diff_sic6_1 := COUNT(GROUP,%Closest%.Diff_sic6_1);
    Count_Diff_sic6_2 := COUNT(GROUP,%Closest%.Diff_sic6_2);
    Count_Diff_sic6_3 := COUNT(GROUP,%Closest%.Diff_sic6_3);
    Count_Diff_sic6_4 := COUNT(GROUP,%Closest%.Diff_sic6_4);
    Count_Diff_sic6_5 := COUNT(GROUP,%Closest%.Diff_sic6_5);
    Count_Diff_transaction_date := COUNT(GROUP,%Closest%.Diff_transaction_date);
    Count_Diff_database_site_id := COUNT(GROUP,%Closest%.Diff_database_site_id);
    Count_Diff_database_individual_id := COUNT(GROUP,%Closest%.Diff_database_individual_id);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_email_present_flag := COUNT(GROUP,%Closest%.Diff_email_present_flag);
    Count_Diff_site_source1 := COUNT(GROUP,%Closest%.Diff_site_source1);
    Count_Diff_site_source2 := COUNT(GROUP,%Closest%.Diff_site_source2);
    Count_Diff_site_source3 := COUNT(GROUP,%Closest%.Diff_site_source3);
    Count_Diff_site_source4 := COUNT(GROUP,%Closest%.Diff_site_source4);
    Count_Diff_site_source5 := COUNT(GROUP,%Closest%.Diff_site_source5);
    Count_Diff_site_source6 := COUNT(GROUP,%Closest%.Diff_site_source6);
    Count_Diff_site_source7 := COUNT(GROUP,%Closest%.Diff_site_source7);
    Count_Diff_site_source8 := COUNT(GROUP,%Closest%.Diff_site_source8);
    Count_Diff_site_source9 := COUNT(GROUP,%Closest%.Diff_site_source9);
    Count_Diff_site_source10 := COUNT(GROUP,%Closest%.Diff_site_source10);
    Count_Diff_individual_source1 := COUNT(GROUP,%Closest%.Diff_individual_source1);
    Count_Diff_individual_source2 := COUNT(GROUP,%Closest%.Diff_individual_source2);
    Count_Diff_individual_source3 := COUNT(GROUP,%Closest%.Diff_individual_source3);
    Count_Diff_individual_source4 := COUNT(GROUP,%Closest%.Diff_individual_source4);
    Count_Diff_individual_source5 := COUNT(GROUP,%Closest%.Diff_individual_source5);
    Count_Diff_individual_source6 := COUNT(GROUP,%Closest%.Diff_individual_source6);
    Count_Diff_individual_source7 := COUNT(GROUP,%Closest%.Diff_individual_source7);
    Count_Diff_individual_source8 := COUNT(GROUP,%Closest%.Diff_individual_source8);
    Count_Diff_individual_source9 := COUNT(GROUP,%Closest%.Diff_individual_source9);
    Count_Diff_individual_source10 := COUNT(GROUP,%Closest%.Diff_individual_source10);
    Count_Diff_email_status := COUNT(GROUP,%Closest%.Diff_email_status);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
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
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_raw_aid := COUNT(GROUP,%Closest%.Diff_raw_aid);
    Count_Diff_ace_aid := COUNT(GROUP,%Closest%.Diff_ace_aid);
    Count_Diff_prep_address_line1 := COUNT(GROUP,%Closest%.Diff_prep_address_line1);
    Count_Diff_prep_address_line_last := COUNT(GROUP,%Closest%.Diff_prep_address_line_last);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
