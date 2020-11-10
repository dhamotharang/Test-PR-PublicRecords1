IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT CarrierReferenceMain_Fields := MODULE
 
EXPORT NumFields := 77;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Alpha','Invalid_AlphaNum','Invalid_Char','Invalid_Date','Invalid_Email','Invalid_Flag','Invalid_Indicator','Invalid_Ocn_Name','Invalid_NotBlank','Invalid_Num','Invalid_SpecialChar','Invalid_Type');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Alpha' => 1,'Invalid_AlphaNum' => 2,'Invalid_Char' => 3,'Invalid_Date' => 4,'Invalid_Email' => 5,'Invalid_Flag' => 6,'Invalid_Indicator' => 7,'Invalid_Ocn_Name' => 8,'Invalid_NotBlank' => 9,'Invalid_Num' => 10,'Invalid_SpecialChar' => 11,'Invalid_Type' => 12,0);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&-/\',. '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&-/\',. '))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&-/\',. '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-@=. '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-@=. '))));
EXPORT InValidMessageFT_Invalid_Email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-@=. '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Flag(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'1 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Flag(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'1 '))));
EXPORT InValidMessageFT_Invalid_Flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('1 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Indicator(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'X '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Indicator(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'X '))));
EXPORT InValidMessageFT_Invalid_Indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('X '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Ocn_Name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Ocn_Name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Ocn_Name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_NotBlank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_NotBlank(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_NotBlank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SpecialChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:/@&#-,&.\' '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_SpecialChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:/@&#-,&.\' '))));
EXPORT InValidMessageFT_Invalid_SpecialChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:/@&#-,&.\' '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_Invalid_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123'),SALT311.HygieneErrors.NotLength('1'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','dt_start','dt_end','ocn','carrier_name','serv','line','prepaid','high_risk_indicator','activation_dt','number_in_service','spid','operator_full_name','is_current','override_file','data_type','ocn_state','overall_ocn','target_ocn','overall_target_ocn','ocn_abbr_name','rural_lec_indicator','small_ilec_indicator','category','carrier_address1','carrier_address2','carrier_floor','carrier_room','carrier_city','carrier_state','carrier_zip','carrier_phone','affiliated_to','overall_company','contact_function','contact_name','contact_title','contact_address1','contact_address2','contact_city','contact_state','contact_zip','contact_phone','contact_fax','contact_email','contact_information','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','append_rawaid','address_type','privacy_indicator');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_reported','dt_last_reported','dt_start','dt_end','ocn','carrier_name','serv','line','prepaid','high_risk_indicator','activation_dt','number_in_service','spid','operator_full_name','is_current','override_file','data_type','ocn_state','overall_ocn','target_ocn','overall_target_ocn','ocn_abbr_name','rural_lec_indicator','small_ilec_indicator','category','carrier_address1','carrier_address2','carrier_floor','carrier_room','carrier_city','carrier_state','carrier_zip','carrier_phone','affiliated_to','overall_company','contact_function','contact_name','contact_title','contact_address1','contact_address2','contact_city','contact_state','contact_zip','contact_phone','contact_fax','contact_email','contact_information','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','append_rawaid','address_type','privacy_indicator');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_first_reported' => 0,'dt_last_reported' => 1,'dt_start' => 2,'dt_end' => 3,'ocn' => 4,'carrier_name' => 5,'serv' => 6,'line' => 7,'prepaid' => 8,'high_risk_indicator' => 9,'activation_dt' => 10,'number_in_service' => 11,'spid' => 12,'operator_full_name' => 13,'is_current' => 14,'override_file' => 15,'data_type' => 16,'ocn_state' => 17,'overall_ocn' => 18,'target_ocn' => 19,'overall_target_ocn' => 20,'ocn_abbr_name' => 21,'rural_lec_indicator' => 22,'small_ilec_indicator' => 23,'category' => 24,'carrier_address1' => 25,'carrier_address2' => 26,'carrier_floor' => 27,'carrier_room' => 28,'carrier_city' => 29,'carrier_state' => 30,'carrier_zip' => 31,'carrier_phone' => 32,'affiliated_to' => 33,'overall_company' => 34,'contact_function' => 35,'contact_name' => 36,'contact_title' => 37,'contact_address1' => 38,'contact_address2' => 39,'contact_city' => 40,'contact_state' => 41,'contact_zip' => 42,'contact_phone' => 43,'contact_fax' => 44,'contact_email' => 45,'contact_information' => 46,'prim_range' => 47,'predir' => 48,'prim_name' => 49,'addr_suffix' => 50,'postdir' => 51,'unit_desig' => 52,'sec_range' => 53,'p_city_name' => 54,'v_city_name' => 55,'st' => 56,'z5' => 57,'zip4' => 58,'cart' => 59,'cr_sort_sz' => 60,'lot' => 61,'lot_order' => 62,'dpbc' => 63,'chk_digit' => 64,'rec_type' => 65,'ace_fips_st' => 66,'fips_county' => 67,'geo_lat' => 68,'geo_long' => 69,'msa' => 70,'geo_blk' => 71,'geo_match' => 72,'err_stat' => 73,'append_rawaid' => 74,'address_type' => 75,'privacy_indicator' => 76,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],[],[],['ALLOW','LENGTHS'],['LENGTHS'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_first_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_last_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_start(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_start(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_start(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_end(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_end(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_end(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_ocn(SALT311.StrType s0) := MakeFT_Invalid_Ocn_Name(s0);
EXPORT InValid_ocn(SALT311.StrType s) := InValidFT_Invalid_Ocn_Name(s);
EXPORT InValidMessage_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_Ocn_Name(wh);
 
EXPORT Make_carrier_name(SALT311.StrType s0) := MakeFT_Invalid_NotBlank(s0);
EXPORT InValid_carrier_name(SALT311.StrType s) := InValidFT_Invalid_NotBlank(s);
EXPORT InValidMessage_carrier_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_NotBlank(wh);
 
EXPORT Make_serv(SALT311.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_serv(SALT311.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_serv(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
 
EXPORT Make_line(SALT311.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_line(SALT311.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_line(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
 
EXPORT Make_prepaid(SALT311.StrType s0) := MakeFT_Invalid_Flag(s0);
EXPORT InValid_prepaid(SALT311.StrType s) := InValidFT_Invalid_Flag(s);
EXPORT InValidMessage_prepaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Flag(wh);
 
EXPORT Make_high_risk_indicator(SALT311.StrType s0) := MakeFT_Invalid_Flag(s0);
EXPORT InValid_high_risk_indicator(SALT311.StrType s) := InValidFT_Invalid_Flag(s);
EXPORT InValidMessage_high_risk_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Flag(wh);
 
EXPORT Make_activation_dt(SALT311.StrType s0) := s0;
EXPORT InValid_activation_dt(SALT311.StrType s) := 0;
EXPORT InValidMessage_activation_dt(UNSIGNED1 wh) := '';
 
EXPORT Make_number_in_service(SALT311.StrType s0) := s0;
EXPORT InValid_number_in_service(SALT311.StrType s) := 0;
EXPORT InValidMessage_number_in_service(UNSIGNED1 wh) := '';
 
EXPORT Make_spid(SALT311.StrType s0) := MakeFT_Invalid_Ocn_Name(s0);
EXPORT InValid_spid(SALT311.StrType s) := InValidFT_Invalid_Ocn_Name(s);
EXPORT InValidMessage_spid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Ocn_Name(wh);
 
EXPORT Make_operator_full_name(SALT311.StrType s0) := MakeFT_Invalid_NotBlank(s0);
EXPORT InValid_operator_full_name(SALT311.StrType s) := InValidFT_Invalid_NotBlank(s);
EXPORT InValidMessage_operator_full_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_NotBlank(wh);
 
EXPORT Make_is_current(SALT311.StrType s0) := s0;
EXPORT InValid_is_current(SALT311.StrType s) := 0;
EXPORT InValidMessage_is_current(UNSIGNED1 wh) := '';
 
EXPORT Make_override_file(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_override_file(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_override_file(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_data_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_data_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_data_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_ocn_state(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_ocn_state(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_ocn_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_overall_ocn(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_overall_ocn(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_overall_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_target_ocn(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_target_ocn(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_target_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_overall_target_ocn(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_overall_target_ocn(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_overall_target_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_ocn_abbr_name(SALT311.StrType s0) := s0;
EXPORT InValid_ocn_abbr_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_ocn_abbr_name(UNSIGNED1 wh) := '';
 
EXPORT Make_rural_lec_indicator(SALT311.StrType s0) := MakeFT_Invalid_Indicator(s0);
EXPORT InValid_rural_lec_indicator(SALT311.StrType s) := InValidFT_Invalid_Indicator(s);
EXPORT InValidMessage_rural_lec_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Indicator(wh);
 
EXPORT Make_small_ilec_indicator(SALT311.StrType s0) := MakeFT_Invalid_Indicator(s0);
EXPORT InValid_small_ilec_indicator(SALT311.StrType s) := InValidFT_Invalid_Indicator(s);
EXPORT InValidMessage_small_ilec_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Indicator(wh);
 
EXPORT Make_category(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_category(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_carrier_address1(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_address1(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_address2(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_floor(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_floor(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_floor(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_room(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_room(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_room(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_city(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_carrier_city(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_carrier_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_carrier_state(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_carrier_state(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_carrier_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_carrier_zip(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_carrier_zip(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_carrier_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_carrier_phone(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_carrier_phone(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_carrier_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_affiliated_to(SALT311.StrType s0) := s0;
EXPORT InValid_affiliated_to(SALT311.StrType s) := 0;
EXPORT InValidMessage_affiliated_to(UNSIGNED1 wh) := '';
 
EXPORT Make_overall_company(SALT311.StrType s0) := s0;
EXPORT InValid_overall_company(SALT311.StrType s) := 0;
EXPORT InValidMessage_overall_company(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_function(SALT311.StrType s0) := s0;
EXPORT InValid_contact_function(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_function(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_name(SALT311.StrType s0) := s0;
EXPORT InValid_contact_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_name(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_title(SALT311.StrType s0) := s0;
EXPORT InValid_contact_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_title(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_address1(SALT311.StrType s0) := s0;
EXPORT InValid_contact_address1(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_address2(SALT311.StrType s0) := s0;
EXPORT InValid_contact_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_city(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_contact_city(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_contact_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_contact_state(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_contact_state(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_contact_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_contact_zip(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_contact_zip(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_contact_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_contact_phone(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_contact_phone(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_contact_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_contact_fax(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_contact_fax(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_contact_fax(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_contact_email(SALT311.StrType s0) := MakeFT_Invalid_Email(s0);
EXPORT InValid_contact_email(SALT311.StrType s) := InValidFT_Invalid_Email(s);
EXPORT InValidMessage_contact_email(UNSIGNED1 wh) := InValidMessageFT_Invalid_Email(wh);
 
EXPORT Make_contact_information(SALT311.StrType s0) := s0;
EXPORT InValid_contact_information(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_information(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_append_rawaid(SALT311.StrType s0) := s0;
EXPORT InValid_append_rawaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_address_type(SALT311.StrType s0) := s0;
EXPORT InValid_address_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_address_type(UNSIGNED1 wh) := '';
 
EXPORT Make_privacy_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_privacy_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_privacy_indicator(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_dt_first_reported;
    BOOLEAN Diff_dt_last_reported;
    BOOLEAN Diff_dt_start;
    BOOLEAN Diff_dt_end;
    BOOLEAN Diff_ocn;
    BOOLEAN Diff_carrier_name;
    BOOLEAN Diff_serv;
    BOOLEAN Diff_line;
    BOOLEAN Diff_prepaid;
    BOOLEAN Diff_high_risk_indicator;
    BOOLEAN Diff_activation_dt;
    BOOLEAN Diff_number_in_service;
    BOOLEAN Diff_spid;
    BOOLEAN Diff_operator_full_name;
    BOOLEAN Diff_is_current;
    BOOLEAN Diff_override_file;
    BOOLEAN Diff_data_type;
    BOOLEAN Diff_ocn_state;
    BOOLEAN Diff_overall_ocn;
    BOOLEAN Diff_target_ocn;
    BOOLEAN Diff_overall_target_ocn;
    BOOLEAN Diff_ocn_abbr_name;
    BOOLEAN Diff_rural_lec_indicator;
    BOOLEAN Diff_small_ilec_indicator;
    BOOLEAN Diff_category;
    BOOLEAN Diff_carrier_address1;
    BOOLEAN Diff_carrier_address2;
    BOOLEAN Diff_carrier_floor;
    BOOLEAN Diff_carrier_room;
    BOOLEAN Diff_carrier_city;
    BOOLEAN Diff_carrier_state;
    BOOLEAN Diff_carrier_zip;
    BOOLEAN Diff_carrier_phone;
    BOOLEAN Diff_affiliated_to;
    BOOLEAN Diff_overall_company;
    BOOLEAN Diff_contact_function;
    BOOLEAN Diff_contact_name;
    BOOLEAN Diff_contact_title;
    BOOLEAN Diff_contact_address1;
    BOOLEAN Diff_contact_address2;
    BOOLEAN Diff_contact_city;
    BOOLEAN Diff_contact_state;
    BOOLEAN Diff_contact_zip;
    BOOLEAN Diff_contact_phone;
    BOOLEAN Diff_contact_fax;
    BOOLEAN Diff_contact_email;
    BOOLEAN Diff_contact_information;
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
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_append_rawaid;
    BOOLEAN Diff_address_type;
    BOOLEAN Diff_privacy_indicator;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_reported := le.dt_first_reported <> ri.dt_first_reported;
    SELF.Diff_dt_last_reported := le.dt_last_reported <> ri.dt_last_reported;
    SELF.Diff_dt_start := le.dt_start <> ri.dt_start;
    SELF.Diff_dt_end := le.dt_end <> ri.dt_end;
    SELF.Diff_ocn := le.ocn <> ri.ocn;
    SELF.Diff_carrier_name := le.carrier_name <> ri.carrier_name;
    SELF.Diff_serv := le.serv <> ri.serv;
    SELF.Diff_line := le.line <> ri.line;
    SELF.Diff_prepaid := le.prepaid <> ri.prepaid;
    SELF.Diff_high_risk_indicator := le.high_risk_indicator <> ri.high_risk_indicator;
    SELF.Diff_activation_dt := le.activation_dt <> ri.activation_dt;
    SELF.Diff_number_in_service := le.number_in_service <> ri.number_in_service;
    SELF.Diff_spid := le.spid <> ri.spid;
    SELF.Diff_operator_full_name := le.operator_full_name <> ri.operator_full_name;
    SELF.Diff_is_current := le.is_current <> ri.is_current;
    SELF.Diff_override_file := le.override_file <> ri.override_file;
    SELF.Diff_data_type := le.data_type <> ri.data_type;
    SELF.Diff_ocn_state := le.ocn_state <> ri.ocn_state;
    SELF.Diff_overall_ocn := le.overall_ocn <> ri.overall_ocn;
    SELF.Diff_target_ocn := le.target_ocn <> ri.target_ocn;
    SELF.Diff_overall_target_ocn := le.overall_target_ocn <> ri.overall_target_ocn;
    SELF.Diff_ocn_abbr_name := le.ocn_abbr_name <> ri.ocn_abbr_name;
    SELF.Diff_rural_lec_indicator := le.rural_lec_indicator <> ri.rural_lec_indicator;
    SELF.Diff_small_ilec_indicator := le.small_ilec_indicator <> ri.small_ilec_indicator;
    SELF.Diff_category := le.category <> ri.category;
    SELF.Diff_carrier_address1 := le.carrier_address1 <> ri.carrier_address1;
    SELF.Diff_carrier_address2 := le.carrier_address2 <> ri.carrier_address2;
    SELF.Diff_carrier_floor := le.carrier_floor <> ri.carrier_floor;
    SELF.Diff_carrier_room := le.carrier_room <> ri.carrier_room;
    SELF.Diff_carrier_city := le.carrier_city <> ri.carrier_city;
    SELF.Diff_carrier_state := le.carrier_state <> ri.carrier_state;
    SELF.Diff_carrier_zip := le.carrier_zip <> ri.carrier_zip;
    SELF.Diff_carrier_phone := le.carrier_phone <> ri.carrier_phone;
    SELF.Diff_affiliated_to := le.affiliated_to <> ri.affiliated_to;
    SELF.Diff_overall_company := le.overall_company <> ri.overall_company;
    SELF.Diff_contact_function := le.contact_function <> ri.contact_function;
    SELF.Diff_contact_name := le.contact_name <> ri.contact_name;
    SELF.Diff_contact_title := le.contact_title <> ri.contact_title;
    SELF.Diff_contact_address1 := le.contact_address1 <> ri.contact_address1;
    SELF.Diff_contact_address2 := le.contact_address2 <> ri.contact_address2;
    SELF.Diff_contact_city := le.contact_city <> ri.contact_city;
    SELF.Diff_contact_state := le.contact_state <> ri.contact_state;
    SELF.Diff_contact_zip := le.contact_zip <> ri.contact_zip;
    SELF.Diff_contact_phone := le.contact_phone <> ri.contact_phone;
    SELF.Diff_contact_fax := le.contact_fax <> ri.contact_fax;
    SELF.Diff_contact_email := le.contact_email <> ri.contact_email;
    SELF.Diff_contact_information := le.contact_information <> ri.contact_information;
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
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_append_rawaid := le.append_rawaid <> ri.append_rawaid;
    SELF.Diff_address_type := le.address_type <> ri.address_type;
    SELF.Diff_privacy_indicator := le.privacy_indicator <> ri.privacy_indicator;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_reported,1,0)+ IF( SELF.Diff_dt_last_reported,1,0)+ IF( SELF.Diff_dt_start,1,0)+ IF( SELF.Diff_dt_end,1,0)+ IF( SELF.Diff_ocn,1,0)+ IF( SELF.Diff_carrier_name,1,0)+ IF( SELF.Diff_serv,1,0)+ IF( SELF.Diff_line,1,0)+ IF( SELF.Diff_prepaid,1,0)+ IF( SELF.Diff_high_risk_indicator,1,0)+ IF( SELF.Diff_activation_dt,1,0)+ IF( SELF.Diff_number_in_service,1,0)+ IF( SELF.Diff_spid,1,0)+ IF( SELF.Diff_operator_full_name,1,0)+ IF( SELF.Diff_is_current,1,0)+ IF( SELF.Diff_override_file,1,0)+ IF( SELF.Diff_data_type,1,0)+ IF( SELF.Diff_ocn_state,1,0)+ IF( SELF.Diff_overall_ocn,1,0)+ IF( SELF.Diff_target_ocn,1,0)+ IF( SELF.Diff_overall_target_ocn,1,0)+ IF( SELF.Diff_ocn_abbr_name,1,0)+ IF( SELF.Diff_rural_lec_indicator,1,0)+ IF( SELF.Diff_small_ilec_indicator,1,0)+ IF( SELF.Diff_category,1,0)+ IF( SELF.Diff_carrier_address1,1,0)+ IF( SELF.Diff_carrier_address2,1,0)+ IF( SELF.Diff_carrier_floor,1,0)+ IF( SELF.Diff_carrier_room,1,0)+ IF( SELF.Diff_carrier_city,1,0)+ IF( SELF.Diff_carrier_state,1,0)+ IF( SELF.Diff_carrier_zip,1,0)+ IF( SELF.Diff_carrier_phone,1,0)+ IF( SELF.Diff_affiliated_to,1,0)+ IF( SELF.Diff_overall_company,1,0)+ IF( SELF.Diff_contact_function,1,0)+ IF( SELF.Diff_contact_name,1,0)+ IF( SELF.Diff_contact_title,1,0)+ IF( SELF.Diff_contact_address1,1,0)+ IF( SELF.Diff_contact_address2,1,0)+ IF( SELF.Diff_contact_city,1,0)+ IF( SELF.Diff_contact_state,1,0)+ IF( SELF.Diff_contact_zip,1,0)+ IF( SELF.Diff_contact_phone,1,0)+ IF( SELF.Diff_contact_fax,1,0)+ IF( SELF.Diff_contact_email,1,0)+ IF( SELF.Diff_contact_information,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_z5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_append_rawaid,1,0)+ IF( SELF.Diff_address_type,1,0)+ IF( SELF.Diff_privacy_indicator,1,0);
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
    Count_Diff_dt_first_reported := COUNT(GROUP,%Closest%.Diff_dt_first_reported);
    Count_Diff_dt_last_reported := COUNT(GROUP,%Closest%.Diff_dt_last_reported);
    Count_Diff_dt_start := COUNT(GROUP,%Closest%.Diff_dt_start);
    Count_Diff_dt_end := COUNT(GROUP,%Closest%.Diff_dt_end);
    Count_Diff_ocn := COUNT(GROUP,%Closest%.Diff_ocn);
    Count_Diff_carrier_name := COUNT(GROUP,%Closest%.Diff_carrier_name);
    Count_Diff_serv := COUNT(GROUP,%Closest%.Diff_serv);
    Count_Diff_line := COUNT(GROUP,%Closest%.Diff_line);
    Count_Diff_prepaid := COUNT(GROUP,%Closest%.Diff_prepaid);
    Count_Diff_high_risk_indicator := COUNT(GROUP,%Closest%.Diff_high_risk_indicator);
    Count_Diff_activation_dt := COUNT(GROUP,%Closest%.Diff_activation_dt);
    Count_Diff_number_in_service := COUNT(GROUP,%Closest%.Diff_number_in_service);
    Count_Diff_spid := COUNT(GROUP,%Closest%.Diff_spid);
    Count_Diff_operator_full_name := COUNT(GROUP,%Closest%.Diff_operator_full_name);
    Count_Diff_is_current := COUNT(GROUP,%Closest%.Diff_is_current);
    Count_Diff_override_file := COUNT(GROUP,%Closest%.Diff_override_file);
    Count_Diff_data_type := COUNT(GROUP,%Closest%.Diff_data_type);
    Count_Diff_ocn_state := COUNT(GROUP,%Closest%.Diff_ocn_state);
    Count_Diff_overall_ocn := COUNT(GROUP,%Closest%.Diff_overall_ocn);
    Count_Diff_target_ocn := COUNT(GROUP,%Closest%.Diff_target_ocn);
    Count_Diff_overall_target_ocn := COUNT(GROUP,%Closest%.Diff_overall_target_ocn);
    Count_Diff_ocn_abbr_name := COUNT(GROUP,%Closest%.Diff_ocn_abbr_name);
    Count_Diff_rural_lec_indicator := COUNT(GROUP,%Closest%.Diff_rural_lec_indicator);
    Count_Diff_small_ilec_indicator := COUNT(GROUP,%Closest%.Diff_small_ilec_indicator);
    Count_Diff_category := COUNT(GROUP,%Closest%.Diff_category);
    Count_Diff_carrier_address1 := COUNT(GROUP,%Closest%.Diff_carrier_address1);
    Count_Diff_carrier_address2 := COUNT(GROUP,%Closest%.Diff_carrier_address2);
    Count_Diff_carrier_floor := COUNT(GROUP,%Closest%.Diff_carrier_floor);
    Count_Diff_carrier_room := COUNT(GROUP,%Closest%.Diff_carrier_room);
    Count_Diff_carrier_city := COUNT(GROUP,%Closest%.Diff_carrier_city);
    Count_Diff_carrier_state := COUNT(GROUP,%Closest%.Diff_carrier_state);
    Count_Diff_carrier_zip := COUNT(GROUP,%Closest%.Diff_carrier_zip);
    Count_Diff_carrier_phone := COUNT(GROUP,%Closest%.Diff_carrier_phone);
    Count_Diff_affiliated_to := COUNT(GROUP,%Closest%.Diff_affiliated_to);
    Count_Diff_overall_company := COUNT(GROUP,%Closest%.Diff_overall_company);
    Count_Diff_contact_function := COUNT(GROUP,%Closest%.Diff_contact_function);
    Count_Diff_contact_name := COUNT(GROUP,%Closest%.Diff_contact_name);
    Count_Diff_contact_title := COUNT(GROUP,%Closest%.Diff_contact_title);
    Count_Diff_contact_address1 := COUNT(GROUP,%Closest%.Diff_contact_address1);
    Count_Diff_contact_address2 := COUNT(GROUP,%Closest%.Diff_contact_address2);
    Count_Diff_contact_city := COUNT(GROUP,%Closest%.Diff_contact_city);
    Count_Diff_contact_state := COUNT(GROUP,%Closest%.Diff_contact_state);
    Count_Diff_contact_zip := COUNT(GROUP,%Closest%.Diff_contact_zip);
    Count_Diff_contact_phone := COUNT(GROUP,%Closest%.Diff_contact_phone);
    Count_Diff_contact_fax := COUNT(GROUP,%Closest%.Diff_contact_fax);
    Count_Diff_contact_email := COUNT(GROUP,%Closest%.Diff_contact_email);
    Count_Diff_contact_information := COUNT(GROUP,%Closest%.Diff_contact_information);
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
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_append_rawaid := COUNT(GROUP,%Closest%.Diff_append_rawaid);
    Count_Diff_address_type := COUNT(GROUP,%Closest%.Diff_address_type);
    Count_Diff_privacy_indicator := COUNT(GROUP,%Closest%.Diff_privacy_indicator);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
